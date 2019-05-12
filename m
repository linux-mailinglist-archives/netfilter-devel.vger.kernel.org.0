Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B53101ADAE
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 May 2019 19:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfELR64 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 12 May 2019 13:58:56 -0400
Received: from mail.us.es ([193.147.175.20]:36004 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfELR64 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 12 May 2019 13:58:56 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7D555190DC4
        for <netfilter-devel@vger.kernel.org>; Sun, 12 May 2019 19:58:54 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6E5DADA709
        for <netfilter-devel@vger.kernel.org>; Sun, 12 May 2019 19:58:54 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 63D37DA701; Sun, 12 May 2019 19:58:54 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 77E7CDA701;
        Sun, 12 May 2019 19:58:52 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 12 May 2019 19:58:52 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 4F4354265A32;
        Sun, 12 May 2019 19:58:52 +0200 (CEST)
Date:   Sun, 12 May 2019 19:58:51 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Laine Stump <laine@redhat.com>
Subject: Re: [ebtables PATCH] Fix incorrect IPv6 prefix formatting
Message-ID: <20190512175851.lmgqyzous36mjscq@salvia>
References: <20190510162413.28609-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510162413.28609-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, May 10, 2019 at 06:24:13PM +0200, Phil Sutter wrote:
> Due to a typo, 127bit prefixes were omitted instead of 128bit ones.

Applied, thanks Phil.
