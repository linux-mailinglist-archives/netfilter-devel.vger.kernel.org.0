Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 367802693C
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 May 2019 19:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfEVRjJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 May 2019 13:39:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbfEVRjI (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 May 2019 13:39:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A96D9285B4;
        Wed, 22 May 2019 17:39:08 +0000 (UTC)
Received: from egarver.localdomain (ovpn-123-106.rdu2.redhat.com [10.10.123.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09D371001F41;
        Wed, 22 May 2019 17:39:07 +0000 (UTC)
Date:   Wed, 22 May 2019 13:39:07 -0400
From:   Eric Garver <eric@garver.life>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org,
        Jones Desougi <jones.desougi+netfilter@gmail.com>
Subject: Re: [nft PATCH v3 2/2] tests/py: Support JSON validation
Message-ID: <20190522173907.sezc2rq7efpoccxj@egarver.localdomain>
Mail-Followup-To: Eric Garver <eric@garver.life>, Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org,
        Jones Desougi <jones.desougi+netfilter@gmail.com>
References: <20190522161453.23096-1-phil@nwl.cc>
 <20190522161453.23096-3-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522161453.23096-3-phil@nwl.cc>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 22 May 2019 17:39:08 +0000 (UTC)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 22, 2019 at 06:14:53PM +0200, Phil Sutter wrote:
> Introduce a new flag -s/--schema to nft-test.py which enables validation
> of any JSON input and output against our schema.
> 
> Make use of traceback module to get more details if validation fails.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
> Changes since v2:
> - Complain if --schema was given but not --json.
> 
> Changes since v1:
> - Adjust commit message to changes from RFC.
> 
> Changes since RFC:
> - Import builtin traceback module unconditionally
> ---

Acked-by: Eric Garver <eric@garver.life>
