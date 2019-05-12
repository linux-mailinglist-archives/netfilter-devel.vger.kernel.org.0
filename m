Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D0C1ADAF
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 May 2019 20:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfELSAt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 12 May 2019 14:00:49 -0400
Received: from mail.us.es ([193.147.175.20]:36374 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfELSAt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 12 May 2019 14:00:49 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7D772190DCF
        for <netfilter-devel@vger.kernel.org>; Sun, 12 May 2019 20:00:47 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 68BD9DA70A
        for <netfilter-devel@vger.kernel.org>; Sun, 12 May 2019 20:00:47 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6808BDA706; Sun, 12 May 2019 20:00:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7216CDA710;
        Sun, 12 May 2019 20:00:45 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 12 May 2019 20:00:45 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 463964265A31;
        Sun, 12 May 2019 20:00:45 +0200 (CEST)
Date:   Sun, 12 May 2019 20:00:44 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Simon Kirby <sim@hostway.ca>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [conntrack-tools PATCH] sync-mode: Also cancel flush timer in
 ALL_FLUSH_CACHE
Message-ID: <20190512180044.5iqaujsev3ylyrjq@salvia>
References: <20190509214146.wvrhwzq7p4woakci@hostway.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509214146.wvrhwzq7p4woakci@hostway.ca>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, May 09, 2019 at 02:41:46PM -0700, Simon Kirby wrote:
> This makes the behaviour of "conntrackd -f" match that of "conntrackd
> -f internal" with resepect to stopping a timer ("conntrackd -t") from
> possibly flushing again in the future.

Applied, thanks Simon.
