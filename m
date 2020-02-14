Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B902D15ED44
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 Feb 2020 18:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390490AbgBNRcy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 14 Feb 2020 12:32:54 -0500
Received: from correo.us.es ([193.147.175.20]:38950 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390298AbgBNRcw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:32:52 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 16D54130E20
        for <netfilter-devel@vger.kernel.org>; Fri, 14 Feb 2020 18:32:51 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 09737DA701
        for <netfilter-devel@vger.kernel.org>; Fri, 14 Feb 2020 18:32:51 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id F3118DA709; Fri, 14 Feb 2020 18:32:50 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1CD89DA701;
        Fri, 14 Feb 2020 18:32:49 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 14 Feb 2020 18:32:49 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 0217642EF4E1;
        Fri, 14 Feb 2020 18:32:48 +0100 (CET)
Date:   Fri, 14 Feb 2020 18:32:47 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH] src: Fix nftnl_assert() on data_len
Message-ID: <20200214173247.2wbrvcqilqfmcqq5@salvia>
References: <20200214172417.11217-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214172417.11217-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 14, 2020 at 06:24:17PM +0100, Phil Sutter wrote:
> Typical idiom for *_get_u*() getters is to call *_get_data() and make
> sure data_len matches what each of them is returning. Yet they shouldn't
> trust *_get_data() to write into passed pointer to data_len since for
> chains and NFTNL_CHAIN_DEVICES attribute, it does not. Make sure these
> assert() calls trigger in those cases.

The intention to catch for unset attributes through the assertion,
right?
