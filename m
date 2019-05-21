Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31578255B7
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 May 2019 18:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfEUQfr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 May 2019 12:35:47 -0400
Received: from mail.us.es ([193.147.175.20]:40972 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbfEUQfr (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 May 2019 12:35:47 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E076815C105
        for <netfilter-devel@vger.kernel.org>; Tue, 21 May 2019 18:35:45 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D10BEDA715
        for <netfilter-devel@vger.kernel.org>; Tue, 21 May 2019 18:35:45 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C6AA6DA712; Tue, 21 May 2019 18:35:45 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C9C6CDA70E;
        Tue, 21 May 2019 18:35:43 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 21 May 2019 18:35:43 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.195.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 987164265A31;
        Tue, 21 May 2019 18:35:43 +0200 (CEST)
Date:   Tue, 21 May 2019 18:35:41 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Eric Garver <e@erig.me>, netfilter-devel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: Re: [nft PATCH 0/3] Resolve cache update woes
Message-ID: <20190521163541.yhfejowfcmqaune3@salvia>
References: <20190517230033.25417-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517230033.25417-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, May 18, 2019 at 01:00:30AM +0200, Phil Sutter wrote:
> This series implements a fix for situations where a cache update removes
> local (still uncommitted) items from cache leading to spurious errors
> afterwards.
> 
> The series is based on Eric's "src: update cache if cmd is more
> specific" patch which is still under review but resolves a distinct
> problem from the one addressed in this series.
> 
> The first patch improves Eric's patch a bit. If he's OK with my change,
> it may very well be just folded into his.

Thanks for your patchset. This fixing up any of the existing tests
that is broken, right?
