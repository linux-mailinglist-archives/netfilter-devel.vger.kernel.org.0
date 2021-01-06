Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EE62EBEB0
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Jan 2021 14:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbhAFNbW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Jan 2021 08:31:22 -0500
Received: from correo.us.es ([193.147.175.20]:56462 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbhAFNbW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:31:22 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 215EEDA723
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Jan 2021 14:30:03 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 14FC7DA704
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Jan 2021 14:30:03 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0AA78DA73D; Wed,  6 Jan 2021 14:30:03 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 06FC4DA704
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Jan 2021 14:30:01 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 06 Jan 2021 14:30:01 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id D99E1426CC84
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Jan 2021 14:30:00 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 0/2] libedit support followup
Date:   Wed,  6 Jan 2021 14:30:33 +0100
Message-Id: <20210106133035.14816-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

This is a follow up to address a few issues with libedit support:
tests/shell now works fine.

Pablo Neira Ayuso (2):
  cli: use plain readline() interface with libedit
  main: fix typo in cli definition

 src/cli.c  | 39 +++++++++++++++++++++++++++++++++++----
 src/main.c |  2 +-
 2 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.20.1

