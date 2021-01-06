Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75702EBDA5
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Jan 2021 13:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbhAFMZi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Jan 2021 07:25:38 -0500
Received: from correo.us.es ([193.147.175.20]:44036 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbhAFMZh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:25:37 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B8B91FC495
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Jan 2021 13:24:16 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AD154DA704
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Jan 2021 13:24:16 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A294EDA789; Wed,  6 Jan 2021 13:24:16 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9268EDA704
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Jan 2021 13:24:14 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 06 Jan 2021 13:24:14 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 6F1AF426CC84
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Jan 2021 13:24:14 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 0/2] follow up work on the libedit support
Date:   Wed,  6 Jan 2021 13:24:34 +0100
Message-Id: <20210106122436.24589-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

This is a follow up to address a few issues with libedit readline
support: tests/shell now works fine.

Pablo Neira Ayuso (2):
  cli: use plain readline() interface
  main: fix typo in cli definition

 src/cli.c  | 21 +++++++++++----------
 src/main.c |  2 +-
 2 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.20.1

