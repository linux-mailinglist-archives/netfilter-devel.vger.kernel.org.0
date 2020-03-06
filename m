Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4911F17C352
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Mar 2020 17:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgCFQ5S (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Mar 2020 11:57:18 -0500
Received: from correo.us.es ([193.147.175.20]:46448 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgCFQ5S (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:57:18 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AF8E66B1A3
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Mar 2020 17:56:59 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A19EBDA7B2
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Mar 2020 17:56:59 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A1027DA788; Fri,  6 Mar 2020 17:56:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5A318DA3C3
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Mar 2020 17:56:57 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 06 Mar 2020 17:56:57 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 2FB234301DE0
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Mar 2020 17:56:57 +0100 (CET)
Date:   Fri, 6 Mar 2020 17:57:13 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables: missing module ownership in
 chain type definitions
Message-ID: <20200306165713.weucbi6kpuhbcqsz@salvia>
References: <20200306164816.139750-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306164816.139750-1-pablo@netfilter.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Mar 06, 2020 at 05:48:16PM +0100, Pablo Neira Ayuso wrote:
> v2: Fix route chain type too.
>     This supersedes https://patchwork.ozlabs.org/patch/1250406/

Scratch this v2.

route is built-in into the core.
