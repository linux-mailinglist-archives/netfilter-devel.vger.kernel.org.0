Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B4F189940
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2020 11:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCRKZM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Mar 2020 06:25:12 -0400
Received: from correo.us.es ([193.147.175.20]:49096 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgCRKZM (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:25:12 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DA5956CB62
        for <netfilter-devel@vger.kernel.org>; Wed, 18 Mar 2020 11:24:41 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C2848DA3A5
        for <netfilter-devel@vger.kernel.org>; Wed, 18 Mar 2020 11:24:41 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A0A8CFC5F8; Wed, 18 Mar 2020 11:24:39 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5C18BFC5F8;
        Wed, 18 Mar 2020 11:24:37 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 18 Mar 2020 11:24:37 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3F1AB42EE38E;
        Wed, 18 Mar 2020 11:24:37 +0100 (CET)
Date:   Wed, 18 Mar 2020 11:25:06 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [bug report] netfilter: nf_tables: add elements with stateful
 expressions
Message-ID: <20200318102506.nkrj2mgyabl3j2xd@salvia>
References: <20200318094531.GA4421@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318094531.GA4421@mwanda>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Mar 18, 2020 at 12:45:31PM +0300, Dan Carpenter wrote:
> Hello Pablo Neira Ayuso,
> 
> The patch 409444522976: "netfilter: nf_tables: add elements with
> stateful expressions" from Mar 11, 2020, leads to the following
> static checker warning:
> 
> 	net/netfilter/nf_tables_api.c:5140 nft_add_set_elem()
> 	warn: passing freed memory 'expr'

This tool was very fast to diagnose, nice.

I posted this patch to address this:

https://patchwork.ozlabs.org/patch/1257035/

Thanks for reporting.
