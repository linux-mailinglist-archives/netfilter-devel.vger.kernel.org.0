Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36B9B31245
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 May 2019 18:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfEaQY4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 31 May 2019 12:24:56 -0400
Received: from mail.us.es ([193.147.175.20]:46692 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfEaQYz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 31 May 2019 12:24:55 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id EEE5880761
        for <netfilter-devel@vger.kernel.org>; Fri, 31 May 2019 18:24:53 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DF6B8DA707
        for <netfilter-devel@vger.kernel.org>; Fri, 31 May 2019 18:24:53 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D54AFDA705; Fri, 31 May 2019 18:24:53 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E6FAFDA702;
        Fri, 31 May 2019 18:24:51 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 31 May 2019 18:24:51 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BCA804265A31;
        Fri, 31 May 2019 18:24:51 +0200 (CEST)
Date:   Fri, 31 May 2019 18:24:51 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Eric Garver <e@erig.me>
Subject: Re: [nft PATCH 4/4] tests/shell: Test large transaction with echo
 output
Message-ID: <20190531162451.dkw2pobqdzkoi6vr@salvia>
References: <20190529131346.23659-1-phil@nwl.cc>
 <20190529131346.23659-5-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529131346.23659-5-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 29, 2019 at 03:13:46PM +0200, Phil Sutter wrote:
> This reliably triggered ENOBUFS condition in mnl_batch_talk(). With the
> past changes, it passes even after increasing the number of rules to
> 300k.

Applied, thanks.
