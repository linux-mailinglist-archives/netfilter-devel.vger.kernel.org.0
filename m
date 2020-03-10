Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FF517FFEF
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2020 15:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgCJOO4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Mar 2020 10:14:56 -0400
Received: from rs2.larkmoor.net ([162.211.66.16]:41108 "EHLO rs2.larkmoor.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgCJOO4 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=larkmoor.net; s=larkmoor20140928;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=t/iQaOuis7ULK6rO/HH7mRUfkMqRKi/flkEOXVr/XHI=;
        b=PcrIs7u9QdTT8htUL5tg0VlRigY+nNtEPQl1vZoaLqHUq3F5BfSrHJNwTLKGL2WS204iosLrDod42HJPdgFQ2PVoQWXTUUhDfCk0A7rBHPE0hHoJV662Rn6Pcpo9hcSsK/M2ma5gfTYTD/aoB1qlQcxW36R51S1IhCa9q3EafD4=;
Received: from [10.0.0.31]
        by gw.larkmoor.net with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <fmyhr@fhmtech.com>)
        id 1jBfep-0006wH-5c; Tue, 10 Mar 2020 10:14:55 -0400
Subject: Re: Restoring rulesets containing dynamic sets with counters
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org
References: <5e5cfaed-d2c6-02e1-8019-dd6ba2613034@fhmtech.com>
 <20200310133738.zi3axvy62xqihrod@salvia>
From:   Frank Myhr <fmyhr@fhmtech.com>
Message-ID: <11cd37e2-6340-a469-c564-d6970841b4cd@fhmtech.com>
Date:   Tue, 10 Mar 2020 10:14:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310133738.zi3axvy62xqihrod@salvia>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On 2020/03/10 09:37, Pablo Neira Ayuso wrote:
> On Mon, Mar 09, 2020 at 07:35:15PM -0400, Frank Myhr wrote:
>> I do want to keep the dynamically-added elements across reboot. Is there a
>> better way to do so?
> 
> This is the userspace patch to update the syntax. Still missing
> remaining bits, but it is doable.

Pablo,

Thank you very much for the userspace patch to load dynamic set element 
counters. Great to have that for applications that need it.

For now I'll stick with released & packaged (debian buster-backports) 
nft, and use sed 's/[ ]\+counter[^,\}]\+//g' on saved rulesets before 
restoring them.

Also found that set elements with limits are not currently supported -- 
and it appears that your patch doesn't add that ability. Not sure what 
other stateful objects people might add to set elements. For limits,
sed 's/[ ]\+limit[^,\}]\+//g' before restoring from saved ruleset works 
for me.

Thanks,
Frank
