Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908E323BEF2
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Aug 2020 19:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgHDRiM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Aug 2020 13:38:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55417 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729703AbgHDRiM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:38:12 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-ScTmgip_Nx-qK1oI6x9G9w-1; Tue, 04 Aug 2020 13:38:09 -0400
X-MC-Unique: ScTmgip_Nx-qK1oI6x9G9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8C3A1005510;
        Tue,  4 Aug 2020 17:38:07 +0000 (UTC)
Received: from localhost (ovpn-115-201.rdu2.redhat.com [10.10.115.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA4B419C58;
        Tue,  4 Aug 2020 17:38:06 +0000 (UTC)
Date:   Tue, 4 Aug 2020 13:38:05 -0400
From:   Eric Garver <eric@garver.life>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, phil@nwl.cc
Subject: Re: [PATCH nft] src: add cookie support for rules
Message-ID: <20200804173805.52fw6m3f5pb4zeh5@egarver>
Mail-Followup-To: Eric Garver <eric@garver.life>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, phil@nwl.cc
References: <20200804142412.7409-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804142412.7409-1-pablo@netfilter.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 04, 2020 at 04:24:12PM +0200, Pablo Neira Ayuso wrote:
> This patch allows users to specify a unsigned 64-bit cookie for rules.
> The userspace application assigns the cookie number for tracking the rule.
> The cookie needs to be non-zero. This cookie value is only relevant to
> userspace since this resides in the user data area.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
> Phil, you suggested a cookie to track rules, here it is. A few notes:
> 
> - This patch is missing json support.
> - No need for kernel update since the cookie is stored in the user data area.

It's also missing the ability to delete a rule using the cookie. I guess
this means userspace will have to fetch the ruleset and map a cookie to
rule handle in order to perform the delete.

    # nft add rule inet foobar input tcp dport 666 accept cookie 1234

    # nft list ruleset
    table inet foobar {
        chain input {
            tcp dport 666 accept cookie 1234
        }
    }

    # nft delete rule inet foobar input cookie 1234
    Error: syntax error, unexpected cookie, expecting handle
    delete rule inet foobar input cookie 1234
                                  ^^^^^^

