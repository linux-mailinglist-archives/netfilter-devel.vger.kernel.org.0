Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CF82DD06F
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Dec 2020 12:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgLQLeb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Dec 2020 06:34:31 -0500
Received: from correo.us.es ([193.147.175.20]:55256 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgLQLeY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Dec 2020 06:34:24 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DDABE18D00F
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Dec 2020 12:33:23 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CCBD1DA78A
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Dec 2020 12:33:23 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C18E8DA722; Thu, 17 Dec 2020 12:33:23 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 90333DA791
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Dec 2020 12:33:21 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 17 Dec 2020 12:33:21 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 77FDA426CC85
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Dec 2020 12:33:21 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 0/2] multi-statement support for set elements
Date:   Thu, 17 Dec 2020 12:33:34 +0100
Message-Id: <20201217113336.9148-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

This patchset adds multi-statement support for set elements. This
requires Linux kernel >= 5.11-rc1 (yet to be released by the time I'm
writing this). The following example shows how to define a dynamic set
that can be updated from the packet path with multi-statement support:

 table x {
        set y {
                type ipv4_addr
                flags dynamic
                timeout 1h
                limit rate 1/second counter
        }
        chain z {
                type filter hook output priority 0;
                add @y { ip daddr limit rate 1/second counter }
        }
 }

You might also want to use this new feature with sets:

 table x {
        set y {
                type ipv4_addr
                limit rate 1/second counter
        }
        chain y {
                type filter hook output priority filter; policy accept;
                ip daddr @y
        }
 }

then, add elements to this set:

 nft add element x y { 192.168.120.234 limit rate 1/second counter }

I'll follow up with a patch to update the test infrastructure to cover
this new feature.

Pablo Neira Ayuso (2):
  src: add support for multi-statement in dynamic sets and maps
  src: add set element multi-statement support

 include/expression.h      |   2 +-
 include/list.h            |   7 +++
 include/rule.h            |   2 +-
 include/statement.h       |   4 +-
 src/evaluate.c            |  82 +++++++++++++++++++++---------
 src/expression.c          |  18 +++++--
 src/json.c                |  10 ++--
 src/mnl.c                 |  17 +++++--
 src/netlink.c             |  69 +++++++++++++++++++++++--
 src/netlink_delinearize.c |  74 ++++++++++++++++++++++-----
 src/netlink_linearize.c   |  41 ++++++++++++---
 src/parser_bison.y        | 104 ++++++++++++++++++++++++--------------
 src/rule.c                |  24 +++++++--
 src/segtree.c             |   6 +--
 src/statement.c           |  34 ++++++++++---
 15 files changed, 373 insertions(+), 121 deletions(-)

--
2.20.1

