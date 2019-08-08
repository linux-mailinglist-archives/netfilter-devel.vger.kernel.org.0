Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48FE786052
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Aug 2019 12:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbfHHKp0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Aug 2019 06:45:26 -0400
Received: from correo.us.es ([193.147.175.20]:33502 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbfHHKp0 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:45:26 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 94856B6C7B
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Aug 2019 12:45:22 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 83E971150B9
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Aug 2019 12:45:22 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 798ECDA72F; Thu,  8 Aug 2019 12:45:22 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0C15AA6A7;
        Thu,  8 Aug 2019 12:45:20 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 08 Aug 2019 12:45:20 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (149.103.108.93.rev.vodafone.pt [93.108.103.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 77FAC4265A2F;
        Thu,  8 Aug 2019 12:45:19 +0200 (CEST)
Date:   Thu, 8 Aug 2019 12:45:11 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 0/2 nft v4] Introduce variables in chain priority and
 policy
Message-ID: <20190808104511.ciyis5p4kryoavmz@salvia>
References: <20190802101207.27719-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802101207.27719-1-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Aug 02, 2019 at 12:12:06PM +0200, Fernando Fernandez Mancera wrote:
> This patch series introduces the use of variables in chain priority and policy
> specification. It also contains tests for invalid cases.

Series applied, thanks Fernando.

> Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1172

Please, close this ticket. Thanks.
