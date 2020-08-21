package main

import "bufio"
import "bytes"
import "errors"
import "fmt"
import "io"
import "os"
import "os/exec"
import "regexp"
import "strconv"
import "strings"
import "time"

type Status struct {
	desktops string
	networks string
	sound    string
	battery  string
	cpu      string
	ram      string
	est      string
	utc      string
}

type CPU_times struct {
	user       int64
	nice       int64
	system     int64
	idle       int64
	iowait     int64
	irq        int64
	softirq    int64
	steal      int64
	guest      int64
	guest_nice int64
}

func get_dates(est chan string, utc chan string, done chan bool) {
	for {
		select {
		case <-done:
			return
		default:
			est_time := time.Now()
			utc_time := est_time.UTC()

			est <- est_time.Format("EST: 2006-01-02 15:04:05")
			utc <- utc_time.Format("UTC: 15:04:05")

			time.Sleep(time.Second)
		}
	}
}

func battery(bat chan string, done chan bool) {

	full_fd, err := os.Open("/sys/class/power_supply/BAT0/charge_full")
	if err != nil {
		panic(err)
	}

	var full_buf, cur_buf, status_buf [64]byte
	n, err := full_fd.Read(full_buf[:])
	if err != nil {
		panic(err)
	}
	full_fd.Close()

	full_val, err := strconv.ParseInt(
		strings.TrimSpace(string(full_buf[:n])), 10, 64)
	if err != nil {
		panic(err)
	}

	cur_fd, err := os.Open("/sys/class/power_supply/BAT0/charge_now")
	if err != nil {
		panic(err)
	}

	status_fd, err := os.Open("/sys/class/power_supply/BAT0/status")
	if err != nil {
		panic(err)
	}

	for {
		select {
		case <-done:
			return
		default:
			_, err := cur_fd.Seek(0, 0)
			if err != nil {
				panic(err)
			}

			n, err := cur_fd.Read(cur_buf[:])
			if err != nil {
				panic(err)
			}

			cur_val, err := strconv.ParseInt(
				strings.TrimSpace(string(cur_buf[:n])), 10, 64)
			if err != nil {
				panic(err)
			}

			_, err = status_fd.Seek(0, 0)
			if err != nil {
				panic(err)
			}

			n, err = status_fd.Read(status_buf[:])
			if err != nil {
				panic(err)
			}

			status_val := strings.TrimSpace(string(status_buf[:n]))
			if err != nil {
				panic(err)
			}

			var tmp string
			if status_val == "Discharging" {
				tmp = "-"
			} else if status_val == "Charging" {
				tmp = "+"
			} else {
				tmp = "*"
			}
			bat <- fmt.Sprintf("BAT: %s%3.2f%%", tmp,
				(float64(cur_val)/float64(full_val))*100.00)
			time.Sleep(5 * time.Second)
		}
	}
}

func sound_level(sound chan string, done chan bool) {

	percent_re, err := regexp.CompilePOSIX("[0-9]*%")
	if err != nil {
		panic(err)
	}

	for {
		select {
		case <-done:
			return
		default:
			sound_out, err := exec.Command("amixer",
				"get", "Master").Output()
			if err != nil {
				panic(err)
			}

			tmp := "VOL: " + string(percent_re.Find(sound_out))
			sound <- tmp
			time.Sleep(2 * time.Second)
		}
	}

}

func parse_cpu_times(times [][]byte) CPU_times {
	var tmp CPU_times
	var err error

	tmp.user, err = strconv.ParseInt(
		strings.TrimSpace(string(times[0])), 10, 64)
	if err != nil {
		panic(err)
	}
	tmp.nice, err = strconv.ParseInt(
		strings.TrimSpace(string(times[1])), 10, 64)
	if err != nil {
		panic(err)
	}

	tmp.system, err = strconv.ParseInt(
		strings.TrimSpace(string(times[2])), 10, 64)
	if err != nil {
		panic(err)
	}

	tmp.idle, err = strconv.ParseInt(
		strings.TrimSpace(string(times[3])), 10, 64)
	if err != nil {
		panic(err)
	}

	tmp.iowait, err = strconv.ParseInt(
		strings.TrimSpace(string(times[4])), 10, 64)
	if err != nil {
		panic(err)
	}

	tmp.irq, err = strconv.ParseInt(
		strings.TrimSpace(string(times[5])), 10, 64)
	if err != nil {
		panic(err)
	}

	tmp.softirq, err = strconv.ParseInt(
		strings.TrimSpace(string(times[6])), 10, 64)
	if err != nil {
		panic(err)
	}

	tmp.steal, err = strconv.ParseInt(
		strings.TrimSpace(string(times[7])), 10, 64)
	if err != nil {
		panic(err)
	}

	tmp.guest, err = strconv.ParseInt(
		strings.TrimSpace(string(times[8])), 10, 64)
	if err != nil {
		panic(err)
	}

	tmp.guest_nice, err = strconv.ParseInt(
		strings.TrimSpace(string(times[9])), 10, 64)
	if err != nil {
		panic(err)
	}

	return tmp
}

func cpu_levels(cpu chan string, done chan bool) {
	var prev, cur CPU_times

	proc_fd, err := os.Open("/proc/stat")
	if err != nil {
		panic(err)
	}
	reader := bufio.NewReader(proc_fd)

	cpu_re, err := regexp.CompilePOSIX(
		/*      user       nice    system    idle    iowait     irq    softirq    steal guest    guest_nice*/
		"cpu +([0-9]+) +([0-9]+) +([0-9]+) +([0-9]+) +([0-9]+) +([0-9]+) +([0-9]+) +([0-9]+) +([0-9]+) +([0-9]+).*",
	)
	if err != nil {
		panic(err)
	}

	cpu_line, err := reader.ReadBytes('\n')
	if err != nil {
		return
		panic(err)
	}
	proc_fd.Seek(0, 0)
	reader.Reset(proc_fd)

	vals := cpu_re.FindSubmatch(cpu_line)
	if vals == nil || len(vals) < 11 {
		panic(errors.New("Could not parse /proc/stat"))
	}

	prev = parse_cpu_times(vals[1:])

	for {
		select {
		case <-done:
			return
		default:
			cpu_line, err := reader.ReadBytes('\n')
			if err != nil {
				return
				panic(err)
			}

			vals := cpu_re.FindSubmatch(cpu_line)
			if vals == nil || len(vals) < 11 {
				panic(errors.New("Could not parse /proc/stat"))
			}

			cur = parse_cpu_times(vals[1:])

			prev_idle := prev.idle + prev.iowait
			idle := cur.idle + cur.iowait

			prev_non_idle := prev.user + prev.nice + prev.system +
				prev.irq + prev.softirq + prev.steal
			non_idle := cur.user + cur.nice + cur.system +
				cur.irq + cur.softirq + cur.steal

			prev_total := prev_idle + prev_non_idle
			total := idle + non_idle

			total = total - prev_total
			idle = idle - prev_idle

			cpu <- fmt.Sprintf("CPU: %.2f%%",
				float64(total-idle)/float64(total))

			prev = cur
			proc_fd.Seek(0, 0)
			reader.Reset(proc_fd)
			time.Sleep(time.Second)
		}
	}
}

func ram_usage(ram chan string, done chan bool) {
	var mem_total, mem_free, mem_other int64
	var cnt int

	mem_total = -1
	mem_free = -1
	mem_other = -1

	proc_fd, err := os.Open("/proc/meminfo")
	if err != nil {
		panic(err)
	}
	reader := bufio.NewReader(proc_fd)

	for {
		select {
		case <-done:
			return
		default:
			cnt = 0
			mem_other = 0

			for {
				ram_bytes, err := reader.ReadBytes('\n')
				if err == io.EOF {
					break
				} else if err != nil {
					panic(err)
				}
				ram_line := string(ram_bytes)

				if strings.HasPrefix(ram_line, "MemTotal:") {
					cnt++
					tmp := strings.Fields(ram_line)

					if len(tmp) < 2 {
						panic(errors.New("Cannot parse /proc/meminfo"))
					}
					mem_total, err = strconv.ParseInt(
						tmp[1], 10, 64)
					if err != nil {
						panic(err)
					}

				} else if strings.HasPrefix(ram_line, "MemFree:") {
					cnt++
					tmp := strings.Fields(ram_line)
					if len(tmp) < 2 {
						panic(errors.New("Cannot parse /proc/meminfo"))
					}
					mem_free, err = strconv.ParseInt(
						tmp[1], 10, 64)
					if err != nil {
						panic(err)
					}
				} else if strings.HasPrefix(ram_line, "Cached:") ||
					strings.HasPrefix(ram_line, "Buffers:") {

					cnt++
					tmp := strings.Fields(ram_line)
					if len(tmp) < 2 {
						panic(errors.New("Cannot parse /proc/meminfo"))
					}
					mem_tmp, err := strconv.ParseInt(
						tmp[1], 10, 64)
					if err != nil {
						panic(err)
					}

					mem_other += mem_tmp
				}

				if cnt >= 4 {
					break
				}
			}

			ram <- fmt.Sprintf("RAM: %d MiB", (mem_total-mem_free-
				mem_other)>>10)

			proc_fd.Seek(0, 0)
			reader.Reset(proc_fd)

			time.Sleep(4 * time.Second)
		}
	}
}

func networks(net chan string, done chan bool) {

	time.Sleep(10 * time.Second)
}

func desktops(desk chan string, done chan bool) {
	pipe_fn, err := exec.Command("bspc", "subscribe", "desktop", "-f").Output()
	if err != nil {
		panic(err)
	}
	pipe_filename := strings.TrimSpace(string(pipe_fn))

	pipe, err := os.OpenFile(
		pipe_filename,
		os.O_RDONLY, 0600)
	if err != nil {
		panic(err)
	}

	cleanup := func() {
		pipe.Close()
		os.Remove(pipe_filename)
	}
	defer cleanup()

	reader := bufio.NewReader(pipe)

	desk_names_out, err := exec.Command("bspc", "query", "-D", "--names").Output()
	if err != nil {
		panic(err)
	}

	desk_names := strings.Split(string(desk_names_out), "\n")

	for {
		select {
		case <-done:
			return
		default:
			output := bytes.Buffer{}
			if err != nil {
				panic(err)
			}

			tmp, err := exec.Command("bspc", "query", "-D",
				"-d", "focused", "--names").Output()
			if err != nil {
				panic(err)
			}
			focused := strings.TrimSpace(string(tmp))

			for _, d := range desk_names {
				output.WriteString(" | ")
				if focused == d {
					output.WriteString("%{R}")
					output.WriteString(d)
					output.WriteString("%{R}")
				} else {
					output.WriteString(d)
				}
			}
			desk <- string(bytes.Trim(output.Bytes(), " |"))

			_, err = reader.ReadBytes('\n')
		}
	}
}

func update_bar(s *Status) {
	/*              DESK    NET SOUND BAT CPU  RAM  EST  UTC*/
	fmt.Printf("%%{l}%s%%{r}%s | %s | %s | %s | %s | %s | %s\n",
		s.desktops, s.networks, s.sound,
		s.battery, s.cpu, s.ram, s.est,
		s.utc)
}

func main() {
	desk := make(chan string)
	net := make(chan string)
	sound := make(chan string)
	bat := make(chan string)
	cpu := make(chan string)
	ram := make(chan string)
	est := make(chan string)
	utc := make(chan string)
	done := make(chan bool)

	go get_dates(est, utc, done)
	go battery(bat, done)
	go sound_level(sound, done)
	go cpu_levels(cpu, done)
	go ram_usage(ram, done)
	//	go networks(net, done)
	go desktops(desk, done)

	var stats Status

	for {
		select {
		case stats.desktops = <-desk:
			update_bar(&stats)
		case stats.networks = <-net:
			update_bar(&stats)
		case stats.sound = <-sound:
			update_bar(&stats)
		case stats.battery = <-bat:
			update_bar(&stats)
		case stats.cpu = <-cpu:
			update_bar(&stats)
		case stats.ram = <-ram:
			update_bar(&stats)
		case stats.est = <-est:
			update_bar(&stats)
		case stats.utc = <-utc:
			update_bar(&stats)
		}
	}
}
