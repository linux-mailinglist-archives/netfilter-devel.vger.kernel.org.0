Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042102354C5
	for <lists+netfilter-devel@lfdr.de>; Sun,  2 Aug 2020 03:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHBBaJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 1 Aug 2020 21:30:09 -0400
Received: from correo.us.es ([193.147.175.20]:39346 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHBBaJ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 1 Aug 2020 21:30:09 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7287CE34C4
        for <netfilter-devel@vger.kernel.org>; Sun,  2 Aug 2020 03:30:08 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 64A99DA73F
        for <netfilter-devel@vger.kernel.org>; Sun,  2 Aug 2020 03:30:08 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5A1A9DA73D; Sun,  2 Aug 2020 03:30:08 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 43976DA722
        for <netfilter-devel@vger.kernel.org>; Sun,  2 Aug 2020 03:30:06 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 02 Aug 2020 03:30:06 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 26FFB4265A2F
        for <netfilter-devel@vger.kernel.org>; Sun,  2 Aug 2020 03:30:06 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 0/2] improve error reporting
Date:   Sun,  2 Aug 2020 03:30:00 +0200
Message-Id: <20200802013002.14916-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

This is a small batch to improve error reporting:

Patch #1 allows for location-based error reporting in expressions, eg.

 # nft add rule x y jump z
 Error: Could not process rule: No such file or directory
 add rule x y jump z
              ^^^^^^

Patch #2 replaces EBUSY by EEXIST in several scenarios that are reported
         to cause confusion among users.

Pablo Neira Ayuso (2):
  netfilter: nf_tables: extended netlink error reporting for expressions
  netfilter: nf_tables: report EEXIST on overlaps

 net/netfilter/nf_tables_api.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.20.1

