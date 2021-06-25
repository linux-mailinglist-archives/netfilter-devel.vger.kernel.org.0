Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF203B49C1
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Jun 2021 22:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhFYUdI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 25 Jun 2021 16:33:08 -0400
Received: from mail.netfilter.org ([217.70.188.207]:52980 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFYUdI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 25 Jun 2021 16:33:08 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 38E0261641;
        Fri, 25 Jun 2021 22:30:45 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     kadlec@netfilter.org
Subject: [PATCH ipset,v4 0/4] nftables to ipset translation infrastructure
Date:   Fri, 25 Jun 2021 22:30:39 +0200
Message-Id: <20210625203043.17265-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Jozsef,

This v4 of the patchset to add the ipset to nftables translation
utility. Example invocation of this new tool is the following:

	# ipset-translate restore < file.ipset

This v4 round includes:

- regression tests: there is at least one test for each ipset type.
- many bugfixes that have been spotted by the regression test
  infrastructure.
- Disentanglement of the ipset_xlate() logic for ADT commands.

to run regression tests:

	# cd tests/xlate
	# ./runtest.sh
	[OK] tests are fine!

The xlate.t file contains the ipset set definitions, then the
xlate.t.nft file contains the expected output in nftables syntax.
In case that there is a mismatch, the diff with the expected output is
provided.

Please, apply, thanks!

Pablo Neira Ayuso (4):
  lib: split parser from command execution
  lib: Detach restore routine from parser
  add ipset to nftables translation infrastructure
  tests: add tests ipset to nftables

 configure.ac                 |   1 +
 include/libipset/Makefile.am |   3 +-
 include/libipset/xlate.h     |   6 +
 lib/ipset.c                  | 588 ++++++++++++++++++++++++++++++++++-
 src/Makefile.am              |   8 +-
 src/ipset-translate.8        |  91 ++++++
 src/ipset.c                  |   8 +-
 tests/xlate/runtest.sh       |  29 ++
 tests/xlate/xlate.t          |  55 ++++
 tests/xlate/xlate.t.nft      |  56 ++++
 10 files changed, 827 insertions(+), 18 deletions(-)
 create mode 100644 include/libipset/xlate.h
 create mode 100644 src/ipset-translate.8
 create mode 100755 tests/xlate/runtest.sh
 create mode 100644 tests/xlate/xlate.t
 create mode 100644 tests/xlate/xlate.t.nft

-- 
2.20.1

