PORTNAME=	Steam-BSD-Runtime-Ports
PORTVERSION=	1.0.2
CATEGORIES=	games
MASTER_SITES=	https://github.com/es-j3/${PORTNAME}/archive/refs/tags/
DISTFILES=      ${PORTVERSION}.tar.gz

MAINTAINER=	alexander.nogal@proton.me
COMMENT=	Steam on FreeBSD with the help of proton
WWW=		https://github.com/es-j3/Steam-BSD-Runtime-Ports

LICENSE=	BSD2CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	wine-devel:emulators/wine-devel \
		wine-proton:emulators/wine-proton \
		zenity:x11/zenity

NO_ARCH=	yes

PLIST_FILES=	bin/steam-bsd-runtime-uninstaller bin/steam-bsd-runtime-installer

do-build:
	@${ECHO} "Building Steam-BSD-Runtime!"

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/steam-bsd-runtime-installer ${STAGEDIR}${PREFIX}/bin/steam-bsd-runtime-installer
	${INSTALL_SCRIPT} ${WRKSRC}/steam-bsd-runtime-uninstaller ${STAGEDIR}${PREFIX}/bin/steam-bsd-runtime-uninstaller

.include <bsd.port.mk>
