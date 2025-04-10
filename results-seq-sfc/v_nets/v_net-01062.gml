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
  id 1062
  arrival_time 22352.73274280946
  lifetime 2255.6990322400384
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 23
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 7
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 49
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 25
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 41
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 7
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 6
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 2
    rom 42
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 32
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 31
    rom 28
  ]
  node [
    id 10
    label "10"
    cpu 24
    gpu 17
    rom 2
  ]
  node [
    id 11
    label "11"
    cpu 11
    gpu 6
    rom 6
  ]
  node [
    id 12
    label "12"
    cpu 15
    gpu 39
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
  edge [
    source 8
    target 9
    bw 14
  ]
  edge [
    source 9
    target 10
    bw 4
  ]
  edge [
    source 10
    target 11
    bw 4
  ]
  edge [
    source 11
    target 12
    bw 45
  ]
]
