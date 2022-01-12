# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{8..10} pypy3 )
inherit distutils-r1

DESCRIPTION="Simplified packaging of Python modules (core module)"
HOMEPAGE="
	https://pypi.org/project/flit-core/
	https://github.com/pypa/flit/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv ~sparc ~x86"

RDEPEND="
	dev-python/tomli[${PYTHON_USEDEP}]
"
BDEPEND="
	test? ( dev-python/testpath[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

src_prepare() {
	rm -r flit_core/vendor || die
	sed -i -e 's:from \.vendor ::' flit_core/*.py || die
	distutils-r1_src_prepare
}
