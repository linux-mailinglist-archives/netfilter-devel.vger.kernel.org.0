Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C579159A73
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Feb 2020 21:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbgBKUXS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 Feb 2020 15:23:18 -0500
Received: from correo.us.es ([193.147.175.20]:39182 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731076AbgBKUXS (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:23:18 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id EF0C6EBACA
        for <netfilter-devel@vger.kernel.org>; Tue, 11 Feb 2020 21:23:16 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E171ADA702
        for <netfilter-devel@vger.kernel.org>; Tue, 11 Feb 2020 21:23:16 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D70B9DA70F; Tue, 11 Feb 2020 21:23:16 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E7B5ADA702;
        Tue, 11 Feb 2020 21:23:14 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 11 Feb 2020 21:23:14 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id B954342EF9E0;
        Tue, 11 Feb 2020 21:23:14 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fasnacht@protonmail.ch
Subject: [PATCH nft 0/4] glob and maximum number of includes
Date:   Tue, 11 Feb 2020 21:23:04 +0100
Message-Id: <20200211202308.90575-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Laurent,

This approach maintains an array of stacks per depth.

The initial three patches comes as a preparation. The last patch is
aiming to fix the issue with glob and the maximum number of includes.

Thanks for your detailed feedback and explanations.

Pablo Neira Ayuso (4):
  scanner: call scanner_push_file() after scanner_push_file()
  scanner: add indesc_file_alloc() helper function
  scanner: call scanner_push_indesc() after scanner_push_file()
  scanner: multi-level input file stack for glob

 include/list.h     |  30 ++++++++++++++
 include/parser.h   |   3 +-
 src/parser_bison.y |   5 ++-
 src/scanner.l      | 120 +++++++++++++++++++++++++++++++++++++----------------
 4 files changed, 119 insertions(+), 39 deletions(-)

-- 
2.11.0

