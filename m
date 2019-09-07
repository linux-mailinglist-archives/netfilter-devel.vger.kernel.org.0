Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1283EAC8E0
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Sep 2019 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394373AbfIGSzg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 7 Sep 2019 14:55:36 -0400
Received: from correo.us.es ([193.147.175.20]:44998 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393429AbfIGSzg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 7 Sep 2019 14:55:36 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D74BEDA711
        for <netfilter-devel@vger.kernel.org>; Sat,  7 Sep 2019 20:55:32 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CA427A7EC5
        for <netfilter-devel@vger.kernel.org>; Sat,  7 Sep 2019 20:55:32 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id BFF41A7EC2; Sat,  7 Sep 2019 20:55:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C83B3A7EC1;
        Sat,  7 Sep 2019 20:55:30 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 07 Sep 2019 20:55:30 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A942F4265A5A;
        Sat,  7 Sep 2019 20:55:30 +0200 (CEST)
Date:   Sat, 7 Sep 2019 20:55:32 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2] src: add synproxy stateful object support
Message-ID: <20190907185532.odf3x26uuh5ctrza@salvia>
References: <20190907183020.738-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907183020.738-1-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Sep 07, 2019 at 08:30:22PM +0200, Fernando Fernandez Mancera wrote:
> Add support for "synproxy" stateful object. For example (for TCP port 80 and
> using maps with saddr):
> 
> table ip foo {
> 	synproxy https-synproxy {
> 		synproxy mss 1460 wscale 7 timestamp sack-perm
> 	}

Please, update syntax, so this looks like:

 	synproxy https-synproxy {
 		mss 1460
                wscale 7
                timestamp sack-perm
 	}

One option per line.

Thanks!
