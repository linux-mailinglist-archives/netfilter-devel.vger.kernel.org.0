Return-Path: <netfilter-devel+bounces-1040-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ED88581B8
	for <lists+netfilter-devel@lfdr.de>; Fri, 16 Feb 2024 16:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F612B21861
	for <lists+netfilter-devel@lfdr.de>; Fri, 16 Feb 2024 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E981C12F5BA;
	Fri, 16 Feb 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnncX3/Z"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73871BDD8;
	Fri, 16 Feb 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098681; cv=none; b=a20zS+amo3jaj/AixEeNY87o2D8+XGcvK6QGc29KvRJc4ungFET4NLZDJ55N6UygWyI3WVwxNXxvzkiDWmPgeg9HLdSxVjpcbB0lQEwU+10jDy1tSxzQkjxX5k3f5RHeHF6OBwdZSvXEK+uVGTt8r/wq2y5BAU49SWV1H5pePPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098681; c=relaxed/simple;
	bh=ImiIy5Evv3Nxyd/izcaMTZ8MPvfs/HsZyGwb33wT+Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avfx3Y9r9/waCS62ioxGdGMZoSeylTMcmbBQPlpWevuOOhg5QrlCwJ/byCBHi6T8YjgzXk+uL8iCLrnLyTHbI4kDEvRxJ8mVLE8JD8NX7FDVxGnNMDUcfr8Ai4uCWh0Pmxm23+E3lvPdvsjFFbnZsewTvECGwbUxTVhkpG/ijtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnncX3/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2782DC433F1;
	Fri, 16 Feb 2024 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708098681;
	bh=ImiIy5Evv3Nxyd/izcaMTZ8MPvfs/HsZyGwb33wT+Ks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pnncX3/Za2GREO7aY1WTmfj55hE+A8jKqaDG8LvtWgtMKQVu1mf2J9b6T64fxqoKb
	 B4HoLMSvfbOR5xVe4svweYAMt/KNDVz3SGwThQmxfXjMJThc5db0HSBHuKIZEDUB/P
	 KL6CGqV6yqa5JjteoBue4q3Z0b5r39tONhVL6CeuCo4aPCEDKlk45MZYbgqbp4BEJT
	 P3beH9qOOt8I58ZeacQvDXP6k16TsLv3J4nTcIP5+14C631Z4Ie6jh/z7NFE9r+CLJ
	 mN/blqGgKXED2KhIyTj1wnQoGkHE4kpqW5qqrj9xv8NyHvFys1By1vjxaNhvkIJi65
	 S254SMYtiel4w==
Message-ID: <36253726-50ad-4d98-bf08-ee9fdb9a6fb1@kernel.org>
Date: Fri, 16 Feb 2024 16:51:17 +0100
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [netfilter-core] [ANN] net-next is OPEN
Content-Language: en-GB, fr-BE
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org,
 David Ahern <dsahern@kernel.org>, coreteam@netfilter.org,
 netdev-driver-reviewers@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
 netfilter-devel@vger.kernel.org
References: <20240123072010.7be8fb83@kernel.org>
 <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
 <65b133e83f53e_225ba129414@willemb.c.googlers.com.notmuch>
 <20240124082255.7c8f7c55@kernel.org> <20240124090123.32672a5b@kernel.org>
 <26616300-dc28-47d1-88bb-1c7247d1699d@kernel.org>
 <ZbFiixyMFpQnxzCH@calendula>
 <7a1014ee-7e1d-4be4-bab2-07ddde8a84b7@kernel.org>
 <ZcNSPoqQkMBenwue@calendula>
 <51bdbaab-a611-4f4d-aa8c-e004102220f3@kernel.org>
 <Zc+BYmrv/0pRKY+w@calendula>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <Zc+BYmrv/0pRKY+w@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Pablo,

Thank you for your reply!

On 16/02/2024 16:38, Pablo Neira Ayuso wrote:
> Hi,
> 
> Sorry for taking a while.
> 
> On Wed, Feb 07, 2024 at 12:33:44PM +0100, Matthieu Baerts wrote:
>> Hi Pablo,
>>
>> Thank you for your reply!
>>
>> On 07/02/2024 10:49, Pablo Neira Ayuso wrote:
>>> Hi Matthieu,
>>>
>>> On Tue, Feb 06, 2024 at 07:31:44PM +0100, Matthieu Baerts wrote:
>>> [...]
>>>> Good point, I understand it sounds better to use 'iptables-nft' in new
>>>> kselftests. I should have added a bit of background and not just a link
>>>> to this commit: at that time (around ~v6.4), we didn't need to force
>>>> using 'iptables-legacy' on -net or net-next tree. But we needed that
>>>> when testing kernels <= v5.15.
>>>>
>>>> When validating (old) stable kernels, the recommended practice is
>>>> apparently [1] to use the kselftests from the last stable version, e.g.
>>>> using the kselftests from v6.7.4 when validating kernel v5.15.148. The
>>>> kselftests are then supposed to support older kernels, e.g. by skipping
>>>> some parts if a feature is not available. I didn't know about that
>>>> before, and I don't know if all kselftests devs know about that.
>>>
>>> We are sending backports to stable kernels, if one stable kernel
>>> fails, then we have to fix it.
>>
>> Do you validate stable kernels by running the kselftests from the same
>> version (e.g. both from v5.15.x) or by using the kselftests from the
>> last stable one (e.g. kernel v5.15.148 validated using the kselftests
>> from v6.7.4)?
> 
> We have kselftests, but nftables/tests/shell probe for kernel
> capabilities then it runs tests according to what the kernel
> supports, this includes packet and control plane path tests. For
> iptables, there are iptables-tests.py for the control plane path.

That's great! It is good to support all the different kernels.

>>>> I don't think that's easy to support old kernels, especially in the
>>>> networking area, where some features/behaviours are not directly exposed
>>>> to the userspace. Some MPTCP kselftests have to look at /proc/kallsyms
>>>> or use other (ugly?) workarounds [2] to predict what we are supposed to
>>>> have, depending on the kernel that is being used. But something has to
>>>> be done, not to have big kselftests, with many different subtests,
>>>> always marked as "failed" when validating new stable releases.
>>>
>>> iptables-nft is supported in all of the existing stable kernels.
>>
>> OK, then we should not have had the bug we had. I thought we were using
>> features that were not supported in v5.15.
> 
> I don't think so, iptables-nft supports the same features as
> iptables-legacy.

We were probably unlucky and hit a kernel/userspace bug that has been
fixed in between, sorry for the noise!

>>>> Back to the modification to use 'iptables-legacy', maybe a kernel config
>>>> was missing, but the same kselftest, with the same list of kconfig to
>>>> add, was not working with the v5.15 kernel, while everything was OK with
>>>> a v6.4 one. With 'iptables-legacy', the test was running fine on both. I
>>>> will check if maybe an old kconfig option was not missing.
>>>
>>> I suspect this is most likely kernel config missing, as it happened to Jakub.
>>
>> Probably, yes. I just retried by testing a v5.15.148 kernel using the
>> kselftests from the net-next tree and forcing iptables-nft: I no longer
>> have the issue I had one year ago. Not sure why, we already had
>> NFT_COMPAT=m back then. Maybe because we recently added IP_NF_FILTER and
>> similar, because we noticed some CI didn't have them?
>> Anyway, I will then switch back to iptables-nft. Thanks for the suggestion!
> 
> Thanks. If you experience any issue, report back to netfilter-devel@

Will do, thank you!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

