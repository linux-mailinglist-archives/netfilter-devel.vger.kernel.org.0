Return-Path: <netfilter-devel+bounces-10724-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJzzH/uPjGlQrAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10724-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 15:19:39 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 025FD12524B
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 15:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA5DC3000532
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED75156C6A;
	Wed, 11 Feb 2026 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sleuthco.ai header.i=@sleuthco.ai header.b="HEOKrH+7"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BE73B2A0
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Feb 2026 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819575; cv=pass; b=LhEJAuCeVf8eknqMEuY1vjORenXHWqKL09JhnLc0Cnt6Lp+QdAygU9scniS2fP5AMIL2L+blZUHw4u1DjmJKSaNiC0hfYIm/Djmose4CH5uzJJTS5SLjxpFZInuFBdXfee5YMlJEW52K7zNKc5kx0OaDCm9H7B0q72tQq/ds0/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819575; c=relaxed/simple;
	bh=iAGH5m6sU6T6fIw7hFQZluf4tQLYZjh2hjVw/grlV1Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JPxu/cu60EcZMrmHhCYsrnd2x0V2dZR+qV6BwCEmFopkP1vFISUIMEWnmyPGC61GEuFzMwlCj4YTbYIUAl0wt07ON7LATAt59I8Bb4b4g5tylJiHG0MqXMay1ktRaLDBosfVlJXpz7FhGi6jGmq0XioKS016H/j0SFxYchZdOP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sleuthco.ai; spf=fail smtp.mailfrom=sleuthco.ai; dkim=pass (2048-bit key) header.d=sleuthco.ai header.i=@sleuthco.ai header.b=HEOKrH+7; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sleuthco.ai
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sleuthco.ai
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7927261a3acso55434217b3.0
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Feb 2026 06:19:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770819573; cv=none;
        d=google.com; s=arc-20240605;
        b=E6vzaP6kaXLxYHAb4iNxm7sMRAmPqt/O7KKo7t53VZExLPWQbr21JQno3geh4er6Xh
         Jg7YH2vBWA5MY8aD7hPcDXkWhBoiTA325qNbim/duDqIFyVEfW968pKOf+gBJMsWUboa
         45Ut/BpmWTkw4KjTJkWlfkA7pYWSpoX7wkqUzvbkuR3HhjPVaV7RJsJB1YjXdpGITsXa
         EGTEeptibrXqgVPofmTlO2uR7n193bRUvcB80W/67KSm4dgm6lEWd6BUnpQ3pNE3C689
         TXT4GEPTYjAl0Fz+77N6eYG/gEAcd2QLN0PnYWYOinmEmxFByi6vu3UoSj+I4BeJDsM1
         /RIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lNJedM+CDtTdgnw+LqTAQCsAg+04blfojizY1uJ/2Xc=;
        fh=94XZ0kbhVmGEa7CVQQn7x19t/0l9HgwgaJK+mk7Jllo=;
        b=EejW530Q/8Y9G8brm410/Wre7G8jECJwuVu/pq4fuZuk/GMVi5AODdtsYkcvNbcyS8
         O/uSbixRkS9np8VWMpuDTRx3d6dJ4ACNVlGozuSnS8GQEVtbiPmrIpEPJzzq4yfTOIB2
         Rd0jZPKzw6TDcXL+FZPohmbQ0TeJ5fcIH7boMg1gkXrD6bwgolG2tGUeCwwW1heGt21k
         77qshvy0AxWzEFZ9vHzVxW06VS0KE4azjp03ruCx+cfmePRTz5ORUrXyyAXNsXLxVa3C
         6BOk99bLBnQb4U67JmMmioCP3WXGxH2vceV9IrY4s1TXhh+Z3qZNYTyt47YGtsnR89nE
         aw8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sleuthco.ai; s=google; t=1770819573; x=1771424373; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lNJedM+CDtTdgnw+LqTAQCsAg+04blfojizY1uJ/2Xc=;
        b=HEOKrH+7Ajaxx/VQEpMLXc8LRUwX+4epRKQhE4InsslnJhDkNt2/gkPbnAkOSg8bBf
         24NyZAS1ga5Q5fm+tGHF4/8R4kCIvgBMbAVqEx1QN3xfRGnaBDX9G7m2px0HdWomYYzc
         h4+SoPpo9vx5ync00ZPzB5SWp/yhnhFkw/nXSpUDg322tjPO3mld9ttjBYcUB5CnTE52
         QZjWnGqNVSS/NVzsX0rg8vGW5ACP7ZhLduu93oY+dPO9P0bwloxIPHlasmLU/xQjeC4x
         +oU94/Rd+vmCALfnXNfXUuvD7F91GxqJM8M1j9k9uP2UiGbdNW7fppMLdaRbiMpe3gaW
         AcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770819573; x=1771424373;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNJedM+CDtTdgnw+LqTAQCsAg+04blfojizY1uJ/2Xc=;
        b=M0UHcFdG4Jlt6iOaQ3XUZAuX9tV7FnYx9XvOaBAJUiz/QfTSvX1RlBelVhYbjmUvYw
         IERKUUhcE9I1eU0PJ6y2sPAOWTWxkHtF7CcjcPW9l4GapjofxPLObfy4i3C8pWHVUlvz
         IKyStLdM4dog/ZUs3yZzSGAN9B3pSR562WbAuykhz9ngg6ETzvj0Kg7fag5aa4A3uflF
         yVOxCuYVJGjIKJtQVuveLL6UCPKiFa5hanFXiW36lvchdxKUItX703ariQMf7NhRoZGE
         +ngfcEpFxGBHODyixxaEzN+ecOOGm3hQ61lS6NGN/4+on3aMtwIUeRDjgEUzOrRXBesj
         paQQ==
X-Gm-Message-State: AOJu0YwUJOY1oGqzF9fQS0puWrjUk6+azftt17WyrH1l93YvyXomCQFO
	GUowT1eD0lusn+ZFSHFnBuHAWCVjadIbwBmSpa9cz61TNTEM3stnf6aPQgeI20w/9zssSTKR+ye
	HCvAtjx8yaQHdoluLI3M4JQYz6sMckyX2aVIA/WSWzNQJBiEsKGJV6NLN4ONWiQ==
X-Gm-Gg: AZuq6aLcj6JC5aHtn7yErx8QDtgDcR/LAycycPc/V7Y62ncXNn5oah+FQJgX/m1Guar
	uLOd2HHDDROAcBs2edCC35u1eY5tkk2TM4lqwC+rUoSCnfTkgss4aSaKlvz2OWuv4k7m8pUlTh1
	IajP7BLxsa+Z+FcfGHHAJIUI9gfm1HGIp2IliZCVWVAlqPOwW/F0ip2Ie8BXb1ahUueV42osWye
	vtvr43oT+RKUf/tjkwUEaExN6z9I5YmKxIVI9KPI+WZrVf3z+KHpGr5pESxhzOGnsbQhEsIHWHP
	Dxzg813Xz6Z7rhDRdUc3WXUKVmaC+BHTYgd1pivc
X-Received: by 2002:a05:690c:7406:b0:795:254a:b431 with SMTP id
 00721157ae682-7966aa91271mr22229497b3.40.1770819572892; Wed, 11 Feb 2026
 06:19:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alan Ross <alan@sleuthco.ai>
Date: Wed, 11 Feb 2026 09:19:24 -0500
X-Gm-Features: AZwV_QiZRBy-qRr1pfVd8jcXskHMb_GAxg85XYy51cBsBfP3zpOB8v46Vo6PwqE
Message-ID: <CAKgz23Gtsg4HGV8qqk7OovcK21ZdpwNzEnzoPzqrW=5eE6jV_w@mail.gmail.com>
Subject: [PATCH] security: use secure_getenv() to prevent env-var privilege escalation
To: netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[sleuthco.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DMARC_NA(0.00)[sleuthco.ai];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alan@sleuthco.ai,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10724-lists,netfilter-devel=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sleuthco.ai:+]
X-Rspamd-Queue-Id: 025FD12524B
X-Rspamd-Action: no action

Hi netfilter team,

  iptables uses getenv() to read XTABLES_LIBDIR, IPTABLES_LIB_DIR,
  IP6TABLES_LIB_DIR, XTABLES_LOCKFILE, and EBTABLES_SAVE_COUNTER. Since
  iptables runs as root, these become local privilege escalation vectors:

   - XTABLES_LIBDIR controls where extensions are loaded via dlopen().
     A local attacker who can inject this variable forces iptables to
     load arbitrary shared libraries as root (CWE-426, CWE-427).

   - XTABLES_LOCKFILE controls where the lock file is created via
     open(path, O_CREAT, 0600). An attacker can create or clobber
     arbitrary files as root.

  This patch replaces getenv() with secure_getenv() for all 5 variables.
  secure_getenv() returns NULL when AT_SECURE is set by the kernel (for
  setuid, setgid, or capability-elevated binaries), blocking env-var
  injection without affecting normal unprivileged usage.

  A portability shim is included for glibc < 2.17. A test program is
  included at tests/test-secure-getenv.c.

  Patch and full details:
  https://github.com/SleuthCo/iptables/compare/master...security/fix-env-var-privilege-escalation

  Signed-off-by: Alan <alan@sleuthco.ai>

