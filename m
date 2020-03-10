Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9638B17FF4D
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2020 14:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgCJNpi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Mar 2020 09:45:38 -0400
Received: from correo.us.es ([193.147.175.20]:57494 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgCJNph (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:45:37 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 95A32FF2C5
        for <netfilter-devel@vger.kernel.org>; Tue, 10 Mar 2020 14:45:15 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 87F18DA3AD
        for <netfilter-devel@vger.kernel.org>; Tue, 10 Mar 2020 14:45:15 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7D8DFDA3AC; Tue, 10 Mar 2020 14:45:15 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C0050DA3A3;
        Tue, 10 Mar 2020 14:45:13 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 10 Mar 2020 14:45:13 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 98EDF42EE38E;
        Tue, 10 Mar 2020 14:45:13 +0100 (CET)
Date:   Tue, 10 Mar 2020 14:45:33 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 0/4] Help and getopt improvements
Message-ID: <20200310134533.zlmol2j6oxujymt6@salvia>
References: <20200305144805.143783-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305144805.143783-1-jeremy@azazel.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 05, 2020 at 02:48:01PM +0000, Jeremy Sowden wrote:
> I spotted a couple more mistakes in the help.  The first two patches fix
> them.  The last patch generates the getopt_long(3) optstring and
> options, and the help from one data-structure in a bid to keep them all
> in sync.

Series applied, thanks.
