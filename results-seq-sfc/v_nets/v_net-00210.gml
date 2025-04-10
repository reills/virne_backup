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
  id 210
  arrival_time 3720.2603580777254
  lifetime 308.04436788089447
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 37
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 1
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 18
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 5
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 39
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 23
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 14
    rom 30
  ]
  node [
    id 7
    label "7"
    cpu 40
    gpu 46
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 33
    gpu 25
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 38
    gpu 31
    rom 39
  ]
  node [
    id 10
    label "10"
    cpu 5
    gpu 49
    rom 2
  ]
  node [
    id 11
    label "11"
    cpu 4
    gpu 27
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 29
  ]
  edge [
    source 8
    target 9
    bw 26
  ]
  edge [
    source 9
    target 10
    bw 0
  ]
  edge [
    source 10
    target 11
    bw 12
  ]
]
