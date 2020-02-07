Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 733F81555CE
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Feb 2020 11:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgBGKfV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Feb 2020 05:35:21 -0500
Received: from correo.us.es ([193.147.175.20]:50700 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgBGKfV (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:35:21 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 879CD2EFED4
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Feb 2020 11:35:20 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 77DDDDA7A3
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Feb 2020 11:35:20 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6B11CDA71A; Fri,  7 Feb 2020 11:35:20 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AABA0FA6D1;
        Fri,  7 Feb 2020 11:34:43 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 07 Feb 2020 11:34:43 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 823ED42EF42A;
        Fri,  7 Feb 2020 11:34:43 +0100 (CET)
Date:   Fri, 7 Feb 2020 11:34:42 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Kadlecsik =?iso-8859-1?Q?J=F3zsef?= <kadlec@blackhole.kfki.hu>,
        Eric Garver <eric@garver.life>, Phil Sutter <phil@nwl.cc>
Subject: Re: [PATCH nft v4 4/4] tests: Introduce test for set with
 concatenated ranges
Message-ID: <20200207103442.3fnk6rrxzny7hvoa@salvia>
References: <cover.1580342294.git.sbrivio@redhat.com>
 <6f1dbaf2ab5a98b2616b14d93ee589a7e741e5f9.1580342294.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f1dbaf2ab5a98b2616b14d93ee589a7e741e5f9.1580342294.git.sbrivio@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jan 30, 2020 at 01:16:58AM +0100, Stefano Brivio wrote:
> This test checks that set elements can be added, deleted, that
> addition and deletion are refused when appropriate, that entries
> time out properly, and that they can be fetched by matching values
> in the given ranges.

I'll keep this back so Phil doesn't have to do some knitting work
meanwhile the tests finishes for those 3 minutes.

If this can be shortened, better. Probably you can add a parameter to
enable the extra torture test mode not that is away from the
./run-test.sh path.
