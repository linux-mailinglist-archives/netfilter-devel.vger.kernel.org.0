Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D1C3030BB
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Jan 2021 01:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbhAZABJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 Jan 2021 19:01:09 -0500
Received: from correo.us.es ([193.147.175.20]:33314 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732733AbhAZABH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 Jan 2021 19:01:07 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4BCF9508CC4
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Jan 2021 00:59:27 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3C969DA730
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Jan 2021 00:59:27 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 32246DA704; Tue, 26 Jan 2021 00:59:27 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 16E6EDA72F;
        Tue, 26 Jan 2021 00:59:25 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 26 Jan 2021 00:59:25 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E572F426CC84;
        Tue, 26 Jan 2021 00:59:24 +0100 (CET)
Date:   Tue, 26 Jan 2021 01:00:22 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2] netfilter: ctnetlink: remove get_ct
 indirection
Message-ID: <20210126000022.GA29019@salvia>
References: <20210120153003.26111-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120153003.26111-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jan 20, 2021 at 04:30:03PM +0100, Florian Westphal wrote:
> Use nf_ct_get() directly, its a small inline helper without dependencies.
> 
> Add CONFIG_NF_CONNTRACK guards to elide the relevant part when conntrack
> isn't available at all.

Applied, thanks.
