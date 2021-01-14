Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E049E2F6E3F
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 Jan 2021 23:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbhANWcv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 14 Jan 2021 17:32:51 -0500
Received: from correo.us.es ([193.147.175.20]:44112 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730730AbhANWcu (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:32:50 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 04248303D0A
        for <netfilter-devel@vger.kernel.org>; Thu, 14 Jan 2021 23:31:21 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EB9EFDA722
        for <netfilter-devel@vger.kernel.org>; Thu, 14 Jan 2021 23:31:20 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E11D9DA78B; Thu, 14 Jan 2021 23:31:20 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A60A6DA722;
        Thu, 14 Jan 2021 23:31:18 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 14 Jan 2021 23:31:18 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 80A3B42DC700;
        Thu, 14 Jan 2021 23:31:18 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     mikhail.sennikovskii@cloud.ionos.com
Subject: [PATCH conntrack-tools 0/3] preparing support for command batch
Date:   Thu, 14 Jan 2021 23:31:59 +0100
Message-Id: <20210114223202.4758-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Mikhail,

This is a patch to prepare for the command batch support.

Please have a look at the xtables restore parser, it would be great
if the code to read the file lines via fgets() and then turn it into
argc and argv (see add_argv() for reference in iptables/xshared.c).
If conntrack can converge to use existing approach in the iptables code, that
will be good for maintainability reasons.

Thanks for your patience.

Pablo Neira Ayuso (3):
  conntrack: add struct ct_cmd
  conntrack: add struct ct_tmpl
  conntrack: add do_command_ct()

 src/conntrack.c | 346 +++++++++++++++++++++++++++---------------------
 1 file changed, 194 insertions(+), 152 deletions(-)

-- 
2.20.1

