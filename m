Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D92BC2D4
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Sep 2019 09:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394650AbfIXHk5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Sep 2019 03:40:57 -0400
Received: from kadath.azazel.net ([81.187.231.250]:33542 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388489AbfIXHk4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fg8hcdx1r2hpd2cmmcHh0uGm7/4xrHU71ZLz/tTK5Vo=; b=Gl+bF/mq9yoAAoTtwqFJbKCcpK
        jScbyRMcZuZPPL9CqDd11LyODKI5BGuXfFj2mWZrpkzuuw0XfHViLlPMQKnzvNxxFqq4TRz9oeNmN
        SBBFpHzJuCPBxbj42zj1t88z0YGf1ikqKptiBYn9j7lwDKZlAInfwf2lvcW9ZaBT38be72QuKavGo
        9sEMU1dPmaqe1Remwdrl+Awat8FaVd3RoEm15i0bOaLoYCpGExy+/fQP/0DGcAUVGDJD/wKBzQVXs
        +G9IZHnlJv5T0GHEXQv5Y2PMt78wJY8VD5jrUPp8TG7eM4hB/RlbBwcdfTvFN6zRDF83grCK1llFP
        /61+SI1Q==;
Received: from ulthar.dreamlands ([192.168.96.2])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1iCfRP-0001Sh-S1; Tue, 24 Sep 2019 08:40:55 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Sebastian Priebe <sebastian.priebe@de.sii.group>
Subject: [PATCH nftables v2 0/2] Add Linenoise support to the CLI.
Date:   Tue, 24 Sep 2019 08:40:53 +0100
Message-Id: <20190924074055.4146-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 192.168.96.2
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Sebastian Priebe [0] requested Linenoise support for the CLI as an
alternative to Readline, so I thought I'd have a go at providing it.
Linenoise is a minimal, zero-config, BSD licensed, Readline replacement
used in Redis, MongoDB, and Android [1].

 0 - https://lore.kernel.org/netfilter-devel/4df20614cd10434b9f91080d0862dd0c@de.sii.group/
 1 - https://github.com/antirez/linenoise/

By default, the CLI continues to be build using Readline, but passing
`--with-cli=linenoise` instead causes Linenoise to be used instead.

`nft -v` has been extended to display what CLI implementation was built
and whether mini-gmp was used.

Changes since v1:

 * dropped the linenoise source from the nftables tree and added an
   `AC_CHECK_LIB` check instead.

Changes since RFC:

 * two tidy-up patches dropped because they have already been applied;
 * source now added to include/ and src/;
 * tests/build/run-tests.sh updated to test `--with-cli=linenoise`;
 * `nft -v` extended.

Jeremy Sowden (2):
  cli: add linenoise CLI implementation.
  main: add more information to `nft -v`.

 configure.ac             | 17 ++++++++---
 include/cli.h            |  2 +-
 src/Makefile.am          |  3 ++
 src/cli.c                | 64 ++++++++++++++++++++++++++++++++++------
 src/main.c               | 28 ++++++++++++++++--
 tests/build/run-tests.sh |  4 +--
 6 files changed, 100 insertions(+), 18 deletions(-)

-- 
2.23.0

