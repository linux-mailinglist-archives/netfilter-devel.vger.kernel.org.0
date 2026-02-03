Return-Path: <netfilter-devel+bounces-10576-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CImmCTY/gWl6FAMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10576-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Feb 2026 01:20:06 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6447BD2E39
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Feb 2026 01:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 747AC303741F
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Feb 2026 00:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB5E17DFE7;
	Tue,  3 Feb 2026 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="nfyti1PC"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D611E868
	for <netfilter-devel@vger.kernel.org>; Tue,  3 Feb 2026 00:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077952; cv=none; b=l5jQvtQtjH1bGwitX8StnK7xX6wypgfJbRtcdDtxLcW8H+6vzlI4QLjFuNrZ2lxXOY7XoV5oaOkkG7EEG2yhu6uRtmCpPu1uj8QJgtSpJ8PzGErfQrmTUKE5B7iMrJUv355IjRgDhuTeudhICUKde31mBELXxekT+57MvBcQxok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077952; c=relaxed/simple;
	bh=bKr5lA0Ddg0tkih0KloqQz4rkG1OVRNdqGkS2tAk1dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+b/F5Uaa/6wSyfmS3RJb1VL03Hoj9jqSjaDErjsIE0V+CGr4yYBvxIjAdBeg9OCU+UBpq3IJH4ue7/37d5h2+iQsAZkbLEVFT2PokHwVuzQBxvapvAE4G8/FYsxe9lQWPXFB7c9FIIJ3evjYwIEMxApy9og/kGpuiH3PZ8xUp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=nfyti1PC; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 696B160179;
	Tue,  3 Feb 2026 01:19:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770077948;
	bh=lPmLFmLTI4pic4AK24KKrmKa+Nmpb+hwMnce9LzBAZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfyti1PC0P+3g6PXHuArF4YTVdEE8tRH2KV17B2ibIPf0Z14jO7zqREkD4xShdx6h
	 Q+zsG9Ty77ucBu/YdS/xVD1yK7+gyWj2heS7jK8dBSxku0gn3xEpMF7X51gcsqeE88
	 ITBGKM+6wRCHVN4DUXFSou+1JeB+13mUvBeMJirBizjWekMsAGzuwaodkfiZvjpUD2
	 0VscxNwoBOvLNCH+I+rYaSlJUorGiGA+32hHbiEcwHoQKvkSZFk9MGj0bXqprLVKKA
	 wgepmFBcDI9un7JFhqchReh2lNdte+MegEYncFvsGa4sB5ADDLSHFbUhRUS9zHsXgQ
	 lMPJBBUT0xz7w==
Date: Tue, 3 Feb 2026 01:19:06 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Mathieu Patenaude <mpatenaude@gmail.com>
Cc: Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: nft bash completion
Message-ID: <aYE--kfgDkYzASQm@chamomile>
References: <CAJ-1uKHCK_yGx7WUAyOpoTn5QJFhu5khG4W17Foj_3ovgTjPwQ@mail.gmail.com>
 <aXzV1cB0zHqe4wwl@orbyte.nwl.cc>
 <CAJ-1uKFUx4zi-g71kKzphzRQJFH36M6SwGwdLpAMjYivbqWmXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-1uKFUx4zi-g71kKzphzRQJFH36M6SwGwdLpAMjYivbqWmXg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10576-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6447BD2E39
X-Rspamd-Action: no action

Hi,

On Fri, Jan 30, 2026 at 01:26:43PM -0500, Mathieu Patenaude wrote:
> Hi Phil,
> 
> Thanks for looking into this, hopefully it's a small break from the
> complex nftables c code ;-)

... interfering in this discussion.

> The current code gets you up to the point where you need to define the
> "object" specifics.  At the shell, the problem I see is the escaping
> of special characters ( { } ; ) and basically not wanting to reproduce
> the entire nft parser in bash.
> 
> I can be very wrong on this, my observation is that most users define
> things using a file (or file "like" or automation) method and mostly
> use shell command line to do "simpler" things. I guess if we wanted
> to auto complete everything at the shell without having to maintain
> the equivalent of the nft option parser in bash, the autocomplete
> would need to be in the nft command itself, i.e. it would be great
> if the "nft --interactive" mode had auto-completion, we could
> somehow find an efficient way to leverage it from bash, removing
> most of the need for the Bash'i'ism ;-)

It would be really good to have this consolidated, then expose a new
option that tells what is possible from an incomplete command.

> But then again, there is the "escaping special characters" fun part.

What is the issue specifically? Would providing some context to the
autocomplete feature help? ie. "autocomplete, but this is bash". Or,
are you already seeing scenarios in which this approach will lead to
ambiguous autocomplete results that are difficult to address?

Or is it just the complexity associate to dealing with the bison
parser, I understand consolidated approach is harder.

> I realize I posted a link to the nft completion itself, but I had a
> note about sudo at the "project" (two files!) level here
> https://github.com/mpatenaude/bash-nft-completion/tree/main

But short term / easier approach that can be replaced by the
consolidated autocompletion in nft later on should also be fine, which
is what I think you're proposing: a script. Given such script can be
simplified later on once the nft consolidated autocompletion is
available.

Are you planning to explore adding support for more complex stuff such
as concatenations and maps?

> The use of sudo / root is required for viewing the current ruleset, so
> as soon as you need to auto complete an actual "object name", yes root
> privileges are needed.  The no password OR cached sudo creds (via sudo
> -v) is a requirement of the former, otherwise it would make the "auto
> completion" pretty awkward, like, a  [tab] "enter your password", each
> time you need to get a list of defined "objects".
> 
> For my use, this was initially put together for the "list" command so
> it allowed the completion of the top most objects, like table, set,
> chain, names.  I based the current version on this  "spec", not very
> technical, but from the man page:
> https://github.com/mpatenaude/bash-nft-completion/blob/main/positional-args-schema.txt.
> 
> Just to be sure I explain this correctly, for example:  nft list set
> <family> <table> <set> will go like this:
> 
> # Prerequisites: cache the sudo credential if you don't have sudo
> configured for NOPASSWD for the /usr/sbin/nft command, or just become
> root...
> [mathp@dev01 /]$ sudo -v
> [sudo] password for mathp:
> 
> # Lists all top level options
> [mathp@dev01 /]$ nft
> -v                  --handle            --numeric           --file
>          delete
> -V                  -s                  -y                  -D
>          create
> --version           --stateless         --numeric-priority  --define
>          get
> -h                  -t                  -p                  -I
>          replace
> --help              --terse             --numeric-protocol
> --includepath       rename
> -i                  -S                  -T                  -d
>          monitor
> --interactive       --service           --numeric-time      --debug
>          list
> -c                  -N                  -e                  reset
>          insert
> --check             --reversedns        --echo              destroy
> -o                  -u                  -j                  flush
> --optimize          --guid              --json              add
> -a                  -n                  -f                  describe
> 
> # once you start the positional options (ex. list) it no longer
> propose -/--flags, will also only propose what can be "listed" or
> "added", etc.
> # If you start typing f[tab] it does auto-complete until "flowtable"
> and propose flowtable and flowtables for example.
> [mathp@dev01 /]$ nft --handle list
> chain       flowtable   quota       table       flowtables  maps        tables
> counter     limit       ruleset     chains      hooks       quotas
> ct          map         set         counters    limits      sets
> 
> # This is where the auto completion is opinionated, it currently
> requires that you select the family, if you skip it, then it stops
> proposing completion
> [mathp@dev01 /]$ nft --handle list set
> arp     bridge  inet    ip      ip6     netdev
> 
> # This is where "root" (sudo) is required, to list the actual table
> names and propose them
> [mathp@dev01 /]$ sudo nft --handle list set inet
> firewalld                  systemd_cgroups_isolation
> 
> # Sudo  required to propose the defined set names for auto complete:
> [mathp@dev01 /]$ sudo nft --handle list set inet systemd_cgroups_isolation
> inbound_only_cgroups  test_set
> 
> # Auto complete the set name.
> [mathp@dev01 /]$ sudo nft --handle list set inet
> systemd_cgroups_isolation inbound_only_cgroups
> table inet systemd_cgroups_isolation {
>         set inbound_only_cgroups { # handle 4
>                 type cgroupsv2
>                 elements = { 48026 }
>         }
> }
> 
> # Adding a set for example, auto completion "propose stuff" until
> "test_set" is entered.
> [mathp@dev01 /]$ sudo nft add set inet systemd_cgroups_isolation
> test_set '{ type ipv4_addr; }'
> 
> # lots of chains, yes it helps auto complete any one of those names ;-)
> [mathp@dev01 /]$ nft list chain inet firewalld
> Display all 117 possibilities? (y or n)
> 
> [mathp@dev01 /]$ nft list chain inet firewalld mangle_PRE
> mangle_PREROUTING                        mangle_PRE_acme_log
> mangle_PREROUTING_POLICIES               mangle_PRE_acme_deny
> mangle_PRE_drop                          mangle_PRE_acme_allow
> mangle_PRE_drop_pre                      mangle_PRE_acme_post
> mangle_PRE_drop_log                      mangle_PRE_policy_allow-host-ipv6
> mangle_PRE_drop_deny                     mangle_PRE_policy_allow-host-ipv6_pre
> mangle_PRE_drop_allow                    mangle_PRE_policy_allow-host-ipv6_log
> mangle_PRE_drop_post                     mangle_PRE_policy_allow-host-ipv6_deny
> mangle_PRE_acme                      mangle_PRE_policy_allow-host-ipv6_allow
> mangle_PRE_acme_pre                  mangle_PRE_policy_allow-host-ipv6_post
> 
> Best,
> Math.
> 
> 
> On Fri, Jan 30, 2026 at 11:01 AM Phil Sutter <phil@nwl.cc> wrote:
> >
> > Hi Mathieu,
> >
> > On Mon, Jan 26, 2026 at 10:26:16PM -0500, Mathieu Patenaude wrote:
> > > Just inquiring to see if there is any interest in adding nft bash
> > > completion to the nftables project tree?  I only found a reference to
> > > it dating back to 2016 (patchwork RFC), but I'm unclear if this was
> > > ever merged or if I'm just looking in the wrong place.
> >
> > AFAIK nothing exists yet.
> >
> > > I wrote something that works:
> > > https://github.com/mpatenaude/bash-nft-completion/blob/main/nft
> > >
> > > Let me know if that can be helpful.
> >
> > Just to clarify:
> >
> > | # - Provides completions up to the start of a statement (until a '{' is needed).
> >
> > So this does not complete statements/expressions when adding a rule, and
> > completing the initial part is limited since it can't find out which
> > ruleset elements exist already unless sudo does not require a password.
> >
> > Is the latter a requirement for the former? I.e., could it continue to
> > complete something like 'nft add rule t c ip ' despite it does not know
> > what "t" or "c" is supposed to be?
> >
> > Cheers, Phil
> 

