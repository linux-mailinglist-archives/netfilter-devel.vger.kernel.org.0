Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6331185D97
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Mar 2020 15:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgCOOdf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 15 Mar 2020 10:33:35 -0400
Received: from correo.us.es ([193.147.175.20]:47594 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgCOOdf (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:33:35 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6EFB7130E20
        for <netfilter-devel@vger.kernel.org>; Sun, 15 Mar 2020 15:33:07 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 60A79DA38F
        for <netfilter-devel@vger.kernel.org>; Sun, 15 Mar 2020 15:33:07 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5630CDA38D; Sun, 15 Mar 2020 15:33:07 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8435ADA7B2
        for <netfilter-devel@vger.kernel.org>; Sun, 15 Mar 2020 15:33:05 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 15 Mar 2020 15:33:05 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 64D184251480
        for <netfilter-devel@vger.kernel.org>; Sun, 15 Mar 2020 15:33:05 +0100 (CET)
Date:   Sun, 15 Mar 2020 15:33:31 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 2/5] netfilter: nf_tables: remove EXPORT_SYMBOL_GPL for
 nft_expr_init()
Message-ID: <20200315143331.oytculkolu4clskw@salvia>
References: <20200311143016.4414-1-pablo@netfilter.org>
 <20200311143016.4414-3-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311143016.4414-3-pablo@netfilter.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Mar 11, 2020 at 03:30:13PM +0100, Pablo Neira Ayuso wrote:
> Not exposed anymore to modules, remove it.

This patch subject is not correct, there is no EXPORT_SYMBOL_GPL
removal.

Instead, this statifies the nft_expr_init() symbol.

I'm going to fix this here before applying.
