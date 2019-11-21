Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF281052AF
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2019 14:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfKUNIa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Nov 2019 08:08:30 -0500
Received: from correo.us.es ([193.147.175.20]:50180 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfKUNI3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:08:29 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 06E36B6BA7
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Nov 2019 14:08:26 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EE219B7FFE
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Nov 2019 14:08:25 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E3458B7FF6; Thu, 21 Nov 2019 14:08:25 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0F8A4598;
        Thu, 21 Nov 2019 14:08:24 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 21 Nov 2019 14:08:24 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E075842EF4E1;
        Thu, 21 Nov 2019 14:08:23 +0100 (CET)
Date:   Thu, 21 Nov 2019 14:08:25 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [RFC 4/4] src: add ability to reset secmarks
Message-ID: <20191121130825.6aergasheie37pzi@salvia>
References: <20191120174357.26112-1-cgzones@googlemail.com>
 <20191120174357.26112-4-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191120174357.26112-4-cgzones@googlemail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 20, 2019 at 06:43:57PM +0100, Christian G�ttsche wrote:
> Add the ability to reset secmark associations between the user-end string representation and the kernel intern secid.
> This allows a lightweight reset, without reloading the whole configuration and resetting all counters etc. .
> 
> *TODO*:
> Pablo suggested to drop this change.
> Are the actual objects in the kernel not destroyed and recreated?
> Or is this functionality useless?

The reset command is useful for stateful objects that collect some
internal state.

Basically, reset allows you to list the existing object state and
reset it, eg. counters.

In this case, secmark is not a stateful object, unless I'm missing
anything, I think we can skip this.
