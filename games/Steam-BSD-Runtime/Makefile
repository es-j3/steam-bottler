PORTNAME=	Steam-BSD-Runtime
DISTVERSION=	1.0.0
CATEGORIES=	games
MASTER_SITES=	https://github.com/es-j3/Steam-BSD-Runtime/archive/refs/tags/
DISTFILES=      ${PORTVERSION}.tar.gz

MAINTAINER=	alexander.nogal@proton.me
COMMENT=	Steam on FreeBSD with the help of Proton
WWW=		https://github.com/es-j3/Steam-BSD-Runtime

LICENSE=	BSD2CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	wine:emulators/wine \
		${LOCALBASE}/wine-proton:emulators/wine-proton \
		zenity:x11/zenity

NO_ARCH=	yes
NO_BUILD=	yes

WRKSRC=		${WRKDIR}/${PORTNAME}-${PORTVERSION}

PLIST_FILES=	bin/steam-bsd-runtime-uninstaller \
		bin/steam-bsd-runtime-installer \
		bin/steam-bsd-runtime-configurator

do-build:
	@${ECHO} "Building Steam-BSD-Runtime!"

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/src/steam-bsd-runtime-installer ${STAGEDIR}${PREFIX}/bin/steam-bsd-runtime-installer
	${INSTALL_SCRIPT} ${WRKSRC}/src/steam-bsd-runtime-uninstaller ${STAGEDIR}${PREFIX}/bin/steam-bsd-runtime-uninstaller
	${INSTALL_SCRIPT} ${WRKSRC}/src/steam-bsd-runtime-configurator ${STAGEDIR}${PREFIX}/bin/steam-bsd-runtime-configurator

.include <bsd.port.mk>
