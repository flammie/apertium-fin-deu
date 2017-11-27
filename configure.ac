## Process this file with autoconfigure to produce configure scripts

## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

AC_INIT([apertium-fin-deu], [0.0.0], [flammie@iki.fi], [apertium-fin-deu], [http://wiki.apertium.org/wiki/apertium-fin-deu])
AM_INIT_AUTOMAKE([-Wall -Werror -Wno-portability foreign])

AC_PROG_LN_S
AC_PROG_AWK

m4_define([required_apertium_version], [3.3.0])
PKG_CHECK_MODULES(APERTIUM,   apertium >= required_apertium_version, [], [PKG_CHECK_MODULES(APERTIUM,   apertium-3.2 >= required_apertium_version)])


AC_PATH_PROG([LTPRINT], [lt-print], [no])
AS_IF([test x$ac_cv_path_LTPRINT = x],
      [AC_MSG_ERROR([You do not have lt-print installed.])])
AS_IF([test x$ac_cv_path_LTPRINT = xno,],
      [AC_MSG_ERROR([You do not have lt-print installed.])])

AC_PATH_PROG(HFSTLEXC, hfst-lexc, no)
AS_IF([test x$ac_cv_path_HFSTLEXC = x],
      [AC_MSG_ERROR([You don't have hfst-lexc installed.])])
AS_IF([test x$ac_cv_path_HFSTLEXC = xno],
      [AC_MSG_ERROR([You don't have hfst-lexc installed.])])
AC_PATH_PROG(HFSTTWOLC, hfst-twolc, no)
AS_IF([test x$ac_cv_path_HFSTTWOLC = x],
      [AC_MSG_ERROR([You don't have hfst-twolc installed.])])
AS_IF([test x$ac_cv_path_HFSTTWOLC = xno],
      [AC_MSG_ERROR([You don't have hfst-twolc installed.])])
AC_PATH_PROG(CGCOMP, cg-comp, no)
AS_IF([test x$ac_cv_path_CGCOMP = x],
      [AC_MSG_ERROR([You don't have cg-comp installed.])])
AS_IF([test x$ac_cv_path_CGCOMP = xno],
      [AC_MSG_ERROR([You don't have cg-comp installed.])])
AC_PATH_PROG(CGPROC, cg-proc, no)
AS_IF([test x$ac_cv_path_CGPROC = x],
      [AC_MSG_ERROR([You don't have cg-proc installed.])])
AS_IF([test x$ac_cv_path_CGPROC = xno],
      [AC_MSG_ERROR([You don't have cg-proc installed.])])
AC_PATH_PROG(LRXCOMP, lrx-comp, no)
AS_IF([test x$ac_cv_path_LRXCOMP = x],
      [AC_MSG_ERROR([You don't have lrx-comp installed.])])
AS_IF([test x$ac_cv_path_LRXCOMP = xno],
      [AC_MSG_ERROR([You don't have lrx-comp installed.])])

AC_PATH_PROG(LRXPROC, lrx-proc, no)
AS_IF([test x$ac_cv_path_LRXPROC = x],
      [AC_MSG_ERROR([You don't have lrx-proc installed.])])
AS_IF([test x$ac_cv_path_LRXPROC = xno],
      [AC_MSG_ERROR([You don't have lrx-proc installed.])])
AC_PATH_PROG(LSXCOMP, lsx-comp, false)
AC_PATH_PROG(LSXPROC, lsx-proc, no)
AM_CONDITIONAL([CAN_LSX], [test x$LSXPROC != xno])

AC_PATH_PROG(PKG_CONFIG, pkg-config, no)
AS_IF([test x$ac_cv_path_PKG_CONFIG = x],
      [AC_MSG_ERROR([You do not have pkg-config installed.])])
AS_IF([test x$ac_cv_path_PKG_CONFIG = xno],
      [AC_MSG_ERROR([You do not have pkg-config installed.])])

AC_PATH_PROG([NIST_BLEU13A], [mteval-v13a.pl], [false])
AC_PATH_PROG([WRAP_XML], [wrap-xml.prompsit-version.sh], [false])

m4_ifdef([AP_CHECK_LING],[],[AC_MSG_ERROR([AP_CHECK_LING not defined, is apertium.m4 in ACLOCAL_PATH? See: http://wiki.apertium.org/wiki/Installation_troubleshooting])])

AP_CHECK_LING([1], [apertium-fin])
AP_CHECK_LING([2], [apertium-deu])

AC_PATH_PROGS([SAXON], [saxon9-transform], [false])
AM_CONDITIONAL([CAN_SAXON], [test x$SAXON != xfalse])
AP_MKINCLUDE

AC_OUTPUT([Makefile apertium-fin-deu.pc t/config.sh])

