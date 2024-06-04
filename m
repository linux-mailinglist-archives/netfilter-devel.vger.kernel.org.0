Return-Path: <netfilter-devel+bounces-2433-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0C38FAEB7
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Jun 2024 11:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75931C212FE
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Jun 2024 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533E8143C46;
	Tue,  4 Jun 2024 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DIC2be7d"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8858D143860
	for <netfilter-devel@vger.kernel.org>; Tue,  4 Jun 2024 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493233; cv=none; b=eUlDpJ5oueyh7znY62mYqYi1OLaXyttgg+2IRE/omqo+v8tBF8XbIE7dK7Xjeh7Q9Rpi52lymLpDGnVbqj1mMW+0qXmtpEH9ymoMtSID74+RS3vxtpJwDGY4zoAW+6Xmx8Oqb1bPhJ0bxcNCpAM8HkohEeuw8XQTImeIFw6BqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493233; c=relaxed/simple;
	bh=D2jU5oSARChmNNCZuwg8yDcYXULvhyEIQRoV+s3GJ2o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tjst3CeU6uwO26U08wK5ATTdUoBc9XNVQRaax716LmctryOLBQIjhD0JRVZIDWI4Y+duwGducIizv3QNEmavnLz3aco9YmLzTfzurr65lPuwu3uNHpa4rHWVEX+gmM6j1rl+TNwQbeLvGxmdoMiAnI4PP+fMxXUCVQ+OI0Oj6Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DIC2be7d; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a63359aaaa6so684326066b.2
        for <netfilter-devel@vger.kernel.org>; Tue, 04 Jun 2024 02:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717493230; x=1718098030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFq7tpSqPveDiLxXj1+bXctSOmCsU5WM6G1TgLnMF4E=;
        b=DIC2be7d1nXxXipAyVXD/Lkl1yyj01onmLsH0kARqDowXUAkepgjX5voKoY6znjuuj
         qVo02AZFpNe6cLFNcgl1RmLO5AEHHmG8UeEV5IOoR8EDweXlQX5ZKeBnSB9e8SUgisz3
         E/du194yP8uGt168wX3MDgWk51vlWoU1GngMIH4URDmetghpdE7JhZ40CNKm3+RSy1Aw
         POCySDHHuSw+vUWtoOZ/VBBJ62Xf3wEXL5Jn+q7nJIaG8ZE4s1REGpPelF9zqirxjNwB
         LqkKD98yiaicrBtHffV4Qpjg2dGTee9SkMqqb+TfKYaQ7C7fddGdrJPKNdymw65Z+Qgb
         tuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717493230; x=1718098030;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFq7tpSqPveDiLxXj1+bXctSOmCsU5WM6G1TgLnMF4E=;
        b=Vz39fptybnABBjAUjQAgDx/KQPS5ve5k+XdMgnsVRfCoepUKbfeNYPrqHpy53QAQRD
         YtmZyZceTSq2o7tNVCXcyIVbGDepBqw86oW4HLUbTlXSETAvDaNEX2zPqW64tcGoXTEA
         4BV7SbfvYu7/N7L1BOPOQmHohxXDQ2lO4xsukzutGLQoUSunWCR18Vner/jxXngxOguB
         RN/ifg/nibz1nMFtHWnbI/70kBgwI6lGCEB9xxYHbXT3xbzvX4yI77cz/3cS7KjhF1kS
         9gXFsVtOGcTbC9E0agg26wgThVL5pAS3+HIpheBKu3hOLMa2i/FVjUZrqozaXHxRw7kp
         k9vg==
X-Forwarded-Encrypted: i=1; AJvYcCVd4nnfJAqsAtLTqrwQZwDR7ctRdKYljvM41PgzIkeck2y30zoChvQYHevNWSiYrw4klOWfX/67+2QdyPYeRh182+jRV4uY1uaX/1GVmoHR
X-Gm-Message-State: AOJu0Yz5sUyvbr4Mie1pLv6gnVbac5SB2g455wz4QgBLkVmGD83tDKRN
	/26QfyRyRkjCmn+0UYH1ok9JNhDU81UkHvbR4N113UXboj7GjsDTUkF/fJULaZY=
X-Google-Smtp-Source: AGHT+IH/8jHjvoRXRq9A58t2qMLFUxjDENPNcf1oh67gqs4xFNC0tXcrBM43MYq2iYNsnSI4K4Askg==
X-Received: by 2002:a17:907:8690:b0:a69:2bce:e424 with SMTP id a640c23a62f3a-a692bcee4b3mr272176866b.1.1717493229789;
        Tue, 04 Jun 2024 02:27:09 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68e940ed6asm378573366b.22.2024.06.04.02.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:27:09 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:27:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Lizhi Xu <lizhi.xu@windriver.com>,
	ebiggers@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, adilger.kernel@dilger.ca,
	coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
	jaegeuk@kernel.org, kadlec@netfilter.org, kuba@kernel.org,
	linux-ext4@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	pablo@netfilter.org,
	syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [PATCH V3] ext4: check hash version and filesystem casefolded
 consistent
Message-ID: <638bf33d-7ab0-4ff0-aece-ab877cff1694@moroto.mountain>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531085647.2918240-1-lizhi.xu@windriver.com>

Hi Lizhi,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lizhi-Xu/ext4-check-hash-version-and-filesystem-casefolded-consistent/20240531-170046
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20240531085647.2918240-1-lizhi.xu%40windriver.com
patch subject: [PATCH V3] ext4: check hash version and filesystem casefolded consistent
config: i386-randconfig-141-20240601 (https://download.01.org/0day-ci/archive/20240602/202406020752.Ii2MU4KP-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406020752.Ii2MU4KP-lkp@intel.com/

smatch warnings:
fs/ext4/super.c:5287 __ext4_fill_super() warn: missing error code 'err'

vim +/err +5287 fs/ext4/super.c

d4fab7b28e2f5d7 Theodore Ts'o           2023-04-27  5280  	err = ext4_block_group_meta_init(sb, silent);
d4fab7b28e2f5d7 Theodore Ts'o           2023-04-27  5281  	if (err)
0d1ee42f27d30ee Alexandre Ratchov       2006-10-11  5282  		goto failed_mount;
0b8e58a140cae2b Andreas Dilger          2009-06-03  5283  
db9345d9e6f075e Jason Yan               2023-03-23  5284  	ext4_hash_info_init(sb);
66b3f078839bbdb Lizhi Xu                2024-05-31  5285  	if (es->s_def_hash_version == DX_HASH_SIPHASH && 
66b3f078839bbdb Lizhi Xu                2024-05-31  5286  	    !ext4_has_feature_casefold(sb))
66b3f078839bbdb Lizhi Xu                2024-05-31 @5287  		goto failed_mount;


Should this be an error path?  err = something?

ac27a0ec112a089 Dave Kleikamp           2006-10-11  5288  
d4fab7b28e2f5d7 Theodore Ts'o           2023-04-27  5289  	err = ext4_handle_clustersize(sb);
d4fab7b28e2f5d7 Theodore Ts'o           2023-04-27  5290  	if (err)
281b59959707dfa Theodore Ts'o           2011-09-09  5291  		goto failed_mount;
960fd856fdc3b08 Theodore Ts'o           2013-07-05  5292  
d4fab7b28e2f5d7 Theodore Ts'o           2023-04-27  5293  	err = ext4_check_geometry(sb, es);
d4fab7b28e2f5d7 Theodore Ts'o           2023-04-27  5294  	if (err)
bfe0a5f47ada40d Theodore Ts'o           2018-06-17  5295  		goto failed_mount;
bfe0a5f47ada40d Theodore Ts'o           2018-06-17  5296  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


