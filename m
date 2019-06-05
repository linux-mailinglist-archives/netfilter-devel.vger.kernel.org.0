Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9631A358A4
	for <lists+netfilter-devel@lfdr.de>; Wed,  5 Jun 2019 10:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfFEIfm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Jun 2019 04:35:42 -0400
Received: from mail.us.es ([193.147.175.20]:59314 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfFEIfm (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:35:42 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 14A2DDA705
        for <netfilter-devel@vger.kernel.org>; Wed,  5 Jun 2019 10:35:40 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 02565DA70B
        for <netfilter-devel@vger.kernel.org>; Wed,  5 Jun 2019 10:35:40 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 018BBDA705; Wed,  5 Jun 2019 10:35:40 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E3BB8DA706;
        Wed,  5 Jun 2019 10:35:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 05 Jun 2019 10:35:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C3C2040705C3;
        Wed,  5 Jun 2019 10:35:37 +0200 (CEST)
Date:   Wed, 5 Jun 2019 10:35:37 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     =?iso-8859-1?Q?St=E9phane?= Veyret <sveyret@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnftnl v4 0/2] add ct expectation support
Message-ID: <20190605083537.nsfbwavpcnjugzzu@salvia>
References: <20190531165145.12123-1-sveyret@gmail.com>
 <CAFs+hh4n3nY5WSFyChinVcGw7PNM6CghwWOdqxJuiM-xOTk0xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFs+hh4n3nY5WSFyChinVcGw7PNM6CghwWOdqxJuiM-xOTk0xw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 05, 2019 at 07:54:46AM +0200, Stéphane Veyret wrote:
> Hi Pablo,
> 
> Is this enough for you to test the “netfilter: nft_ct: add ct
> expectations support” patch or would you like me to also send the nft
> patch ?

Please, submit this too, thanks.
