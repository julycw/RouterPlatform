package viewfunc

import (
	"fmt"
)

func FormatFileSize(fileSize int) string {
	kb := fileSize / 1024
	if kb > 0 {
		return fmt.Sprintf("%dKB", kb)
	} else {
		return fmt.Sprintf("%dB", fileSize)
	}
}
