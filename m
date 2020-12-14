Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC95B2D9F11
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Dec 2020 19:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440844AbgLNSbU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Dec 2020 13:31:20 -0500
Received: from correo.us.es ([193.147.175.20]:42854 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440843AbgLNSbI (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:31:08 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A442CEB472
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Dec 2020 19:30:11 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 94B68FC5E0
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Dec 2020 19:30:11 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 8A36ADA730; Mon, 14 Dec 2020 19:30:11 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 62498DA704;
        Mon, 14 Dec 2020 19:30:09 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 14 Dec 2020 19:30:09 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3A3934265A5A;
        Mon, 14 Dec 2020 19:30:09 +0100 (CET)
Date:   Mon, 14 Dec 2020 19:30:23 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH 1/2] set_elem: Use nftnl_data_reg_snprintf()
Message-ID: <20201214183023.GA9271@salvia>
References: <20201214180251.11408-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201214180251.11408-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Dec 14, 2020 at 07:02:50PM +0100, Phil Sutter wrote:
> Introduce a flag to allow toggling the '0x' prefix when printing data
> values, then use the existing routines to print data registers from
> set_elem code.

Patches LGTM.

You will have to update tests/py too, right?

Thanks.
