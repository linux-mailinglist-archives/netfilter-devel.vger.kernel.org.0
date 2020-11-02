Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D11C2A2EE1
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Nov 2020 17:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgKBQAY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Nov 2020 11:00:24 -0500
Received: from correo.us.es ([193.147.175.20]:45798 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgKBQAY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:00:24 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7D3E2120845
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Nov 2020 17:00:22 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6F062DA78A
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Nov 2020 17:00:22 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6E600DA704; Mon,  2 Nov 2020 17:00:22 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 472FADA78C
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Nov 2020 17:00:20 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 02 Nov 2020 17:00:20 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 2A21642EF42C
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Nov 2020 17:00:20 +0100 (CET)
Date:   Mon, 2 Nov 2020 17:00:19 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH conntrack] conntrack: do not allow to update offload
 status bits
Message-ID: <20201102160019.GA17428@salvia>
References: <20201102134938.15452-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102134938.15452-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Nov 02, 2020 at 02:49:38PM +0100, Pablo Neira Ayuso wrote:
> libnetfilter_conntrack already prints these new offload status bits,
> which is sufficient. Revert the status parser changes that allow to set
> on these bits from ctnetlink since this is not supported.

Scratch this.

Parser is still useful for the filter, ie.

conntrack -L --status OFFLOAD

I'll explore a patch to disallow updating these bits from -U instead.
