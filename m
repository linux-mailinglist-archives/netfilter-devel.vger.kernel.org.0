Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E84C29C92
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 May 2019 18:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390532AbfEXQ6P (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 24 May 2019 12:58:15 -0400
Received: from mail.us.es ([193.147.175.20]:49700 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390210AbfEXQ6P (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 24 May 2019 12:58:15 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7D75EC3307
        for <netfilter-devel@vger.kernel.org>; Fri, 24 May 2019 18:58:12 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6AE09DA70D
        for <netfilter-devel@vger.kernel.org>; Fri, 24 May 2019 18:58:12 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 60401DA704; Fri, 24 May 2019 18:58:12 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2B3ADDA704;
        Fri, 24 May 2019 18:58:10 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 24 May 2019 18:58:10 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.219.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 07321406B681;
        Fri, 24 May 2019 18:58:09 +0200 (CEST)
Date:   Fri, 24 May 2019 18:58:08 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Eric Garver <eric@garver.life>
Subject: Re: [nft PATCH v2 1/3] src: update cache if cmd is more specific
Message-ID: <20190524165808.foqoths4drgwtewz@salvia>
References: <20190522194406.16827-1-phil@nwl.cc>
 <20190522194406.16827-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522194406.16827-2-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 22, 2019 at 09:44:04PM +0200, Phil Sutter wrote:
> From: Eric Garver <eric@garver.life>
> 
> If we've done a partial fetch of the cache and the genid is the same the
> cache update will be skipped without fetching the needed items. This
> change flushes the cache if the new request is more specific than the
> current cache - forcing a cache update which includes the needed items.
> 
> Introduces a simple scoring system which reflects how
> cache_init_objects() looks at the current command to decide if it is
> finished already or not. Then use that in cache_needs_more(): If current
> command's score is higher than old command's, cache needs an update.

Applied this one, thanks Phil and Eric.
