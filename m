Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C752693A
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 May 2019 19:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfEVRiH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 May 2019 13:38:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbfEVRiH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 May 2019 13:38:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60958301E12F;
        Wed, 22 May 2019 17:38:07 +0000 (UTC)
Received: from egarver.localdomain (ovpn-123-106.rdu2.redhat.com [10.10.123.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7F616198B;
        Wed, 22 May 2019 17:38:06 +0000 (UTC)
Date:   Wed, 22 May 2019 13:38:05 -0400
From:   Eric Garver <eric@garver.life>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org,
        Jones Desougi <jones.desougi+netfilter@gmail.com>
Subject: Re: [nft PATCH v3 1/2] py: Implement JSON validation in nftables
 module
Message-ID: <20190522173805.k2shblya27cntlg3@egarver.localdomain>
Mail-Followup-To: Eric Garver <eric@garver.life>, Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org,
        Jones Desougi <jones.desougi+netfilter@gmail.com>
References: <20190522161453.23096-1-phil@nwl.cc>
 <20190522161453.23096-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522161453.23096-2-phil@nwl.cc>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 22 May 2019 17:38:07 +0000 (UTC)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 22, 2019 at 06:14:52PM +0200, Phil Sutter wrote:
> Using jsonschema it is possible to validate any JSON input to make sure
> it formally conforms with libnftables JSON API requirements.
> 
> Implement a simple validator class for use within a new Nftables class
> method 'json_validate' and ship a minimal schema definition along with
> the package.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
> Changes since v2:
> - Replace file() as that is not supported by python3, instead use open()
>   and that fancy 'with' statement.
> ---

Thanks Phil!

Acked-by: Eric Garver <eric@garver.life>
