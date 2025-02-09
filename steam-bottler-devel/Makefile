PORTNAME=       steam-bottler
DISTVERSION=    1.0.2
CATEGORIES=     games
MASTER_SITES=   https://github.com/es-j3/${PORTNAME}/archive/${PORTVERSION}${EXTRACT_SUFX}?dummy=/

MAINTAINER=     alexander.nogal@proton.me
COMMENT=        Steam Windows gaming in a wine bottle on FreeBSD
WWW=            https://github.com/es-j3/steam-bottler

LICENSE=        BSD2CLAUSE
LICENSE_FILE=   ${WRKSRC}/LICENSE

ONLY_FOR_ARCHS= amd64 i386
ONLY_FOR_ARCHS_REASON=  Wine is only supported on x86 platforms

RUN_DEPENDS=    wine:emulators/wine-devel \
		${LOCALBASE}/wine-proton:emulators/wine-proton \
		winetricks:emulators/winetricks \
		zenity:x11/zenity

NO_BUILD=       yes

WRKSRC=         ${WRKDIR}/${PORTNAME}-${PORTVERSION}

PLIST_FILES=    bin/steam-bottler-uninstaller \
		bin/steam-bottler-installer \
		bin/steam-bottler-configurator

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/src/steam-bottler-installer ${STAGEDIR}${PREFIX}/bin/steam-bottler-installer
	${INSTALL_SCRIPT} ${WRKSRC}/src/steam-bottler-uninstaller ${STAGEDIR}${PREFIX}/bin/steam-bottler-uninstaller
	${INSTALL_SCRIPT} ${WRKSRC}/src/steam-bottler-configurator ${STAGEDIR}${PREFIX}/bin/steam-bottler-configurator

.include <bsd.port.mk>
