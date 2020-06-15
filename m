Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3591FA30D
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2020 23:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgFOVsw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 15 Jun 2020 17:48:52 -0400
Received: from correo.us.es ([193.147.175.20]:49640 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgFOVsv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:48:51 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E5BF6ADCE0
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Jun 2020 23:48:50 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D4ECFDA73D
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Jun 2020 23:48:50 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id CA227DA722; Mon, 15 Jun 2020 23:48:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C0B17DA73D;
        Mon, 15 Jun 2020 23:48:48 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 15 Jun 2020 23:48:48 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A14F4426CCBA;
        Mon, 15 Jun 2020 23:48:48 +0200 (CEST)
Date:   Mon, 15 Jun 2020 23:48:48 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: Run in separate network namespace, don't
 break connectivity
Message-ID: <20200615214848.GA31180@salvia>
References: <8efb5334f8b4df21b8833e576abd5721486c0182.1592170411.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8efb5334f8b4df21b8833e576abd5721486c0182.1592170411.git.sbrivio@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jun 14, 2020 at 11:41:57PM +0200, Stefano Brivio wrote:
> It might be convenient to run tests from a development branch that
> resides on another host, and if we break connectivity on the test
> host as tests are executed, we can't run them this way.
> 
> If kernel implementation (CONFIG_NET_NS), unshare(1), or Python
> bindings for unshare() are not available, warn and continue.

Applied, thanks.
