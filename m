Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F8F2C4B0E
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Nov 2020 23:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgKYWvT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Nov 2020 17:51:19 -0500
Received: from correo.us.es ([193.147.175.20]:48944 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728153AbgKYWvT (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Nov 2020 17:51:19 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 15822EA2A7
        for <netfilter-devel@vger.kernel.org>; Wed, 25 Nov 2020 23:51:18 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 07CDDDA73F
        for <netfilter-devel@vger.kernel.org>; Wed, 25 Nov 2020 23:51:18 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id F1A2CDA4C2; Wed, 25 Nov 2020 23:51:17 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 37664DA73F;
        Wed, 25 Nov 2020 23:51:15 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 25 Nov 2020 23:51:15 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 12A3F4265A5A;
        Wed, 25 Nov 2020 23:51:15 +0100 (CET)
Date:   Wed, 25 Nov 2020 23:51:14 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>
Subject: [HEADS UP] Rebasing nf tree
Message-ID: <20201125225114.GA26607@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi!

I'm rebasing the nf tree to amend the following patchset:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20201121123601.21733-2-pablo@netfilter.org/

This patch passed the netfilter-devel mailing scrutiny as usual, but
Jakub (Netdev maintainer) is not happy about this patch description
and he found that there is a symbol that is exported that should not.

I'll fix the patch and revamp.

I'm sorry for the inconvenience.
