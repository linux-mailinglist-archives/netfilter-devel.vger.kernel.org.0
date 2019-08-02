Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE4E7F549
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Aug 2019 12:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfHBKpD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Aug 2019 06:45:03 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:33168 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbfHBKpD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:45:03 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1htV3W-0002i1-BS; Fri, 02 Aug 2019 12:45:02 +0200
Date:   Fri, 2 Aug 2019 12:45:02 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ander Juaristi <a@juaristi.eus>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v6] meta: Introduce new conditions 'time', 'day' and
 'hour'
Message-ID: <20190802104502.yeunepvge6ohnjsm@breakpoint.cc>
References: <20190802071038.5509-1-a@juaristi.eus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802071038.5509-1-a@juaristi.eus>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ander Juaristi <a@juaristi.eus> wrote:
> --- a/tests/py/ip/meta.t.payload
> +++ b/tests/py/ip/meta.t.payload
> @@ -1,3 +1,87 @@
> +# meta time "1970-05-23 21:07:14" drop
> +ip meta-test input
> +  [ meta load unknown => reg 1 ]

This "unknown" should not exist anymore after your libnftnl patch.
