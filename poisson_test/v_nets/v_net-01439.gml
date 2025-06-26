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
  id 1439
  arrival_time 30217.84122488634
  lifetime 3568.764736747107
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 42
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 22
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 28
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 41
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 9
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 19
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 22
    gpu 31
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 6
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 19
    rom 3
  ]
  node [
    id 9
    label "9"
    cpu 38
    gpu 15
    rom 21
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 22
    rom 13
  ]
  node [
    id 11
    label "11"
    cpu 27
    gpu 19
    rom 47
  ]
  node [
    id 12
    label "12"
    cpu 17
    gpu 3
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 18
  ]
  edge [
    source 9
    target 10
    bw 34
  ]
  edge [
    source 10
    target 11
    bw 41
  ]
  edge [
    source 11
    target 12
    bw 32
  ]
]
