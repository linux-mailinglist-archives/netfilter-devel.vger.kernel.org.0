Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17B3C1782A1
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Mar 2020 20:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgCCS4L (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Mar 2020 13:56:11 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:50336 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgCCS4L (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:56:11 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (uk.solarflare.com [193.34.186.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A9316B40073;
        Tue,  3 Mar 2020 18:56:08 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ukex01.SolarFlarecom.com
 (10.17.10.4) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 3 Mar 2020
 18:55:58 +0000
Subject: Re: [patch net-next v2 01/12] flow_offload: Introduce offload of HW
 stats type
To:     Jakub Kicinski <kuba@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
CC:     Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, <saeedm@mellanox.com>, <leon@kernel.org>,
        <michael.chan@broadcom.com>, <vishal@chelsio.com>,
        <jeffrey.t.kirsher@intel.com>, <idosch@mellanox.com>,
        <aelior@marvell.com>, <peppe.cavallaro@st.com>,
        <alexandre.torgue@st.com>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <mlxsw@mellanox.com>,
        <netfilter-devel@vger.kernel.org>
References: <20200228172505.14386-1-jiri@resnulli.us>
 <20200228172505.14386-2-jiri@resnulli.us>
 <20200229192947.oaclokcpn4fjbhzr@salvia> <20200301084443.GQ26061@nanopsycho>
 <20200302132016.trhysqfkojgx2snt@salvia>
 <1da092c0-3018-7107-78d3-4496098825a3@solarflare.com>
 <20200302192437.wtge3ze775thigzp@salvia>
 <20200302121852.50a4fccc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200302214659.v4zm2whrv4qjz3pe@salvia>
 <20200302144928.0aca19a0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <9478af72-189f-740e-5a6d-608670e5b734@solarflare.com>
Date:   Tue, 3 Mar 2020 18:55:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200302144928.0aca19a0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-ClientProxiedBy: ocex03.SolarFlarecom.com (10.20.40.36) To
 ukex01.SolarFlarecom.com (10.17.10.4)
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1020-25266.003
X-TM-AS-Result: No-2.744600-8.000000-10
X-TMASE-MatchedRID: eVEkOcJu0F7mLzc6AOD8DfHkpkyUphL9hhy6s2hQl4QTvdh6VFADyYEQ
        k1c2BTxcoZjv0XwCLb2myB5m8hwFFbSi69HcXkHAelGHXZKLL2s5OMMyyCn/wY+l4fZNSHju0HC
        C1wXiE/JjKQQkLPRfGSsJ3UZwlB55k9O+qsrqbkGb73wAA/f83YvkwJz527bYHDQcqEqNN+lMU/
        WtoPEtPRFjIqInsEvXkUhQ/uawuoLfJt2GYIjmPKiUivh0j2Pv8vvksslXuLdICmt7k5mXsOgKp
        c0co1LdldHSVwB28HQz6YO/uWL1UBN+JiqkEYnpvOAv94sAIMSm8MsuWwAf/XPW+p0zOs/DcVol
        GMdkWBsNgbJdgH8J1n41niV9Kymzv1l2Uvx6idoWeMpVNhsMwMRB0bsfrpPInxMyeYT53Rk4Er4
        2x9UbhyPJV3U4NJYzM4zAL+Exl8npRhzSIJy2HR7XxSfUMN/ogn6dxoL/waps8BRP+tW4I+nBuq
        h6Ahfe8LyUw/+7GprUNewp4E2/TgSpmVYGQlZ3sxk1kV1Ja8cbbCVMcs1jUlZca9RSYo/b
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.744600-8.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1020-25266.003
X-MDID: 1583261770-8jR3ixQofMLp
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On 02/03/2020 22:49, Jakub Kicinski wrote:
> On Mon, 2 Mar 2020 22:46:59 +0100 Pablo Neira Ayuso wrote:
>> On Mon, Mar 02, 2020 at 12:18:52PM -0800, Jakub Kicinski wrote:
>>> On Mon, 2 Mar 2020 20:24:37 +0100 Pablo Neira Ayuso wrote:  
>>>> It looks to me that you want to restrict the API to tc for no good
>>>> _technical_ reason.  

The technical reason is that having two ways to do things where one would
 suffice means more code to be written, tested, debugged.  So if you want
 to add this you need to convince us that the existing way (a) doesn't
 meet your needs and (b) can't be extended to cover them.

> Also neither proposal addresses the problem of reporting _different_
> counter values at different stages in the pipeline, i.e. moving from
> stats per flow to per action. But nobody seems to be willing to work 
> on that.
For the record, I produced a patch series[1] to support that, but it
 wasn't acceptable because none of the in-tree drivers implemented the
 facility.  My hope is that we'll be upstreaming our new driver Real
 Soon Now™, at which point I'll rebase and repost those changes.
Alternatively if any other vendor wants to support it in their driver
 they could use those patches as a base.

-ed

[1]: http://patchwork.ozlabs.org/cover/1110071/ ("flow_offload: Re-add per-action statistics")
