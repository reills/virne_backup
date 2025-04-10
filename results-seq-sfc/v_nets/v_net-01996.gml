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
  id 1996
  arrival_time 43506.89633154026
  lifetime 321.9666769693307
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 9
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 20
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 43
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 14
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 27
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 36
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 11
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 8
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 39
    gpu 38
    rom 19
  ]
  node [
    id 9
    label "9"
    cpu 17
    gpu 0
    rom 14
  ]
  node [
    id 10
    label "10"
    cpu 26
    gpu 22
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 24
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 25
  ]
  edge [
    source 9
    target 10
    bw 15
  ]
]
