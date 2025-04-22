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
  id 1736
  arrival_time 38790.563633880105
  lifetime 1748.6069410354767
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 31
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 44
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 9
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 29
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 41
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 28
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 15
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 27
    gpu 33
    rom 37
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 12
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 41
    gpu 45
    rom 10
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 23
    rom 45
  ]
  node [
    id 11
    label "11"
    cpu 1
    gpu 19
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 22
  ]
  edge [
    source 9
    target 10
    bw 8
  ]
  edge [
    source 10
    target 11
    bw 30
  ]
]
