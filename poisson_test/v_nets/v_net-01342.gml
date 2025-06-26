graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1342
  arrival_time 28411.708675388752
  lifetime 1537.5483951843535
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 7
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 26
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 0
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 7
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 29
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 45
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 36
    rom 50
  ]
  node [
    id 7
    label "7"
    cpu 49
    gpu 11
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 42
    gpu 17
    rom 35
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 27
    rom 0
  ]
  node [
    id 10
    label "10"
    cpu 33
    gpu 10
    rom 28
  ]
  node [
    id 11
    label "11"
    cpu 12
    gpu 5
    rom 23
  ]
  node [
    id 12
    label "12"
    cpu 17
    gpu 40
    rom 7
  ]
  node [
    id 13
    label "13"
    cpu 35
    gpu 36
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 30
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 31
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 1
  ]
  edge [
    source 9
    target 10
    bw 8
  ]
  edge [
    source 10
    target 11
    bw 14
  ]
  edge [
    source 11
    target 12
    bw 40
  ]
  edge [
    source 12
    target 13
    bw 16
  ]
]
