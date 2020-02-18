Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87273162781
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Feb 2020 14:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBRN4z (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Feb 2020 08:56:55 -0500
Received: from correo.us.es ([193.147.175.20]:49028 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgBRN4z (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:56:55 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 486E9C1B6C
        for <netfilter-devel@vger.kernel.org>; Tue, 18 Feb 2020 14:56:54 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3A7D4DA3C4
        for <netfilter-devel@vger.kernel.org>; Tue, 18 Feb 2020 14:56:54 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 30429DA8E6; Tue, 18 Feb 2020 14:56:54 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 66E96DA801;
        Tue, 18 Feb 2020 14:56:52 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 18 Feb 2020 14:56:52 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 4A83542EE38F;
        Tue, 18 Feb 2020 14:56:52 +0100 (CET)
Date:   Tue, 18 Feb 2020 14:56:51 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org,
        Stefano Brivio <sbrivio@redhat.com>
Subject: Re: [iptables PATCH] ebtables: among: Support mixed MAC and MAC/IP
 entries
Message-ID: <20200218135651.x6el7lciqsfi32kw@salvia>
References: <20200214104910.21196-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214104910.21196-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 14, 2020 at 11:49:10AM +0100, Phil Sutter wrote:
> Powered by Stefano's support for concatenated ranges, a full among match
> replacement can be implemented. The trick is to add MAC-only elements as
> a concatenation of MAC and zero-length prefix, i.e. a range from
> 0.0.0.0 till 255.255.255.255.
> 
> Although not quite needed, detection of pure MAC-only matches is left in
> place. For those, no implicit 'meta protocol' match is added (which is
> required otherwise at least to keep nft output correct) and no concat
> type is used for the set.

I'm glad to see this, thanks Phil.

Is ebt among is now complete?

Thanks.
