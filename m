Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE55333097
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Mar 2021 22:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhCIVCT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Mar 2021 16:02:19 -0500
Received: from correo.us.es ([193.147.175.20]:60870 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhCIVBs (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:01:48 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B8DD2DA709
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 22:01:44 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A72E5DA722
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 22:01:44 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9BD6DDA78A; Tue,  9 Mar 2021 22:01:44 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 58F1FDA722;
        Tue,  9 Mar 2021 22:01:42 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 09 Mar 2021 22:01:42 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 2F42D42DF562;
        Tue,  9 Mar 2021 22:01:42 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, fmyhr@fhmtech.com, stefanh@hafenthal.de
Subject: [PATCH RFC nf-next 0/2] ct helper object name matching
Date:   Tue,  9 Mar 2021 22:01:32 +0100
Message-Id: <20210309210134.13620-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

[ Compile tested-only and userspace update is missing ]

This patchset adds NFT_CT_HELPER_OBJNAME to match on the helper object name, ie.

From nftables, existing (inconsistent) syntax can be left in place for
backward compatibility. The new proposed syntax would more explicitly
refer to match the user wants to do, e.g.

	ct helper name set "ftp-21"
	ct helper name "ftp-21"

For NFT_CT_HELPER_TYPE (formerly NFT_CT_HELPER), syntax would be:

	ct helper type "ftp"

It should be also possible to support for:

	ct helper type set "ftp"

via implicit object, this infrastructure is missing in the kernel
though, the idea would be to create an implicit object that is attached
to the rule.  Such object would be released when the rule is removed.

Let me know.

Pablo Neira Ayuso (2):
  netfilter: nftables: rename NFT_CT_HELPER to NFT_CT_HELPER_TYPE
  netfilter: nftables: add NFT_CT_HELPER_OBJNAME

 include/net/netfilter/nf_conntrack_helper.h |  1 +
 include/uapi/linux/netfilter/nf_tables.h    |  7 +++--
 net/netfilter/nf_conntrack_helper.c         |  1 +
 net/netfilter/nft_ct.c                      | 30 +++++++++++++++++----
 4 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.20.1

