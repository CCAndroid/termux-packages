TERMUX_PKG_HOMEPAGE=https://maunium.net/go/mautrix-whatsapp/
TERMUX_PKG_DESCRIPTION="A Matrix-WhatsApp puppeting bridge"
TERMUX_PKG_LICENSE="AGPL-V3"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="0.10.0"
TERMUX_PKG_SRCURL=https://github.com/mautrix/whatsapp/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=f2819bde4fe6d36f744044ffdf630c3e6311225bf85ab309fd587e080249e6c0
TERMUX_PKG_DEPENDS="libolm"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true

termux_step_pre_configure() {
	termux_setup_golang

	go mod init || :
	go mod tidy
}

termux_step_make() {
	go build -ldflags "-X 'main.BuildTime=$(date '+%b %_d %Y, %H:%M:%S')'"
}

termux_step_make_install() {
	install -Dm700 -t $TERMUX_PREFIX/bin mautrix-whatsapp
	install -Dm600 -t $TERMUX_PREFIX/share/doc/$TERMUX_PKG_NAME example-config.yaml
}
