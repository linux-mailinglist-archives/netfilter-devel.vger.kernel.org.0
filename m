Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24693BC2CF
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Sep 2019 09:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405067AbfIXHkg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Sep 2019 03:40:36 -0400
Received: from kadath.azazel.net ([81.187.231.250]:33494 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394650AbfIXHkf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6NaNsrxU16SDh6FjDULaOTwcyGZuPsObHyGIX8x3b00=; b=uElfJ8rt/eVvHgL/Gh8G3Ozm8n
        gi2+bD3OaHyNdkHDKvkUNGLrUXr9CA1Fc9C7FKBSSSZ9oQadePX3wLQ8tzZvP4yg6e2k7Owjv7naX
        T425pjnZNK3pDJUafWKgtmKQZ51PU0PCsJXeQI0bQaDItVb8dMaBWTV5k/glyMLnkTaRnkUmhsAMe
        Jy5BKJN7wM+bT+Lg4REtlA6txHb949kc6R0lsQw6i0dcQpA2DucmLiMYjjATXg9DyL7kMQjwvz6l/
        XFO9uwglOx37C6QmeMGIEDoEnxhExoq/+VC5eC9Egn89JhADKDh/sB4dp+leAkcyfRlq9yeCaywtC
        gf7cWI/w==;
Received: from ulthar.dreamlands ([192.168.96.2])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1iCfR4-0001Re-Ge; Tue, 24 Sep 2019 08:40:34 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Sebastian Priebe <sebastian.priebe@de.sii.group>
Subject: [PATCH nftables 0/3] Add Linenoise support to the CLI.
Date:   Tue, 24 Sep 2019 08:40:31 +0100
Message-Id: <20190924074034.4099-1-jeremy@azazel.net>
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

The upstream repo doesn't contain the infrastructure for building or
installing libraries.  I've taken a look at how Redis and MongoDB handle
this, and they both include the upstream sources in their trees (MongoDB
actually uses a C++ fork, Linenoise NG [2]), so I've done the same.

 2 - https://github.com/arangodb/linenoise-ng

By default, the CLI continues to be build using Readline, but passing
`--with-cli=linenoise` instead causes Linenoise to be used instead.

`nft -v` has been extended to display what CLI implementation was built
and whether mini-gmp was used.

Changes since RFC:

 * two tidy-up patches dropped because they have already been applied;
 * source now added to include/ and src/;
 * tests/build/run-tests.sh updated to test `--with-cli=linenoise`;
 * `nft -v` extended.

Jeremy Sowden (3):
  src, include: add upstream linenoise source.
  cli: add linenoise CLI implementation.
  main: add more information to `nft -v`.

 configure.ac             |   14 +-
 include/Makefile.am      |    1 +
 include/cli.h            |    2 +-
 include/linenoise.h      |   73 +++
 src/Makefile.am          |   12 +
 src/cli.c                |   64 +-
 src/linenoise.c          | 1201 ++++++++++++++++++++++++++++++++++++++
 src/main.c               |   28 +-
 tests/build/run-tests.sh |    4 +-
 9 files changed, 1381 insertions(+), 18 deletions(-)
 create mode 100644 include/linenoise.h
 create mode 100644 src/linenoise.c

-- 
2.23.0

