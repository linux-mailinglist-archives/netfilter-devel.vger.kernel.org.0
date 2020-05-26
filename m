Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2472E1BEA08
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2020 23:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgD2VgN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 29 Apr 2020 17:36:13 -0400
Received: from correo.us.es ([193.147.175.20]:58226 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgD2VgN (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:36:13 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 52B8012BFE7
        for <netfilter-devel@vger.kernel.org>; Wed, 29 Apr 2020 23:36:12 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 44FC2615D0
        for <netfilter-devel@vger.kernel.org>; Wed, 29 Apr 2020 23:36:12 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 3AA8D5764D; Wed, 29 Apr 2020 23:36:12 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 50931DA736;
        Wed, 29 Apr 2020 23:36:10 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 29 Apr 2020 23:36:10 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 32FD442EF9E2;
        Wed, 29 Apr 2020 23:36:10 +0200 (CEST)
Date:   Wed, 29 Apr 2020 23:36:09 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 00/18] iptables: introduce cache evaluation
 phase
Message-ID: <20200429213609.GA24368@salvia>
References: <20200428121013.24507-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428121013.24507-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Phil,

On Tue, Apr 28, 2020 at 02:09:55PM +0200, Phil Sutter wrote:
> Hi Pablo,
> 
> As promised, here's a revised version of your cache rework series from
> January. It restores performance according to my tests (which are yet to
> be published somewhere) and passes the testsuites.

I did not test this yet, and I made a few rounds of quick reviews
alrady, but this series LGTM. Thank you for working on this.
